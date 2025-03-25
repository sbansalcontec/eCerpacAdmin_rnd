using eCerpac_NIS.App_Code;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing.Imaging;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZXing.QrCode;
using ZXing;
using System.Web.UI.HtmlControls;

namespace eCerpac_NIS
{
    public partial class frmNISCGApproval : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(CommonFunctions.connection.ToString());
        DataTable dt_login_details = new DataTable();

        private string grdLevel3flag;
        private string currentSortColumn
        {
            get { return ViewState["SortColumn"] != null ? ViewState["SortColumn"].ToString() : string.Empty; }
            set { ViewState["SortColumn"] = value; }
        }

        private string currentSortOrder
        {
            get { return ViewState["SortOrder"] != null ? ViewState["SortOrder"].ToString() : string.Empty; }
            set { ViewState["SortOrder"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //----------Load Fun-----------------
            try
            {
                if (Session["LoginId"] == null)
                {
                    Server.Transfer("Login.aspx", false);
                }

                dt_login_details = (DataTable)Session["LoginDetails"];

                if (!IsPostBack)
                {
                    bindgrid();

                    pnlMain.Attributes.Add("style", "display:block;");
                    // pnldisplay.Attributes.Add("style", "display:none;");
                    ///  pnlmsg.Attributes.Add("style", "display:none;");
                }

                lblloginmsg.Text = "";
            }

            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }
        }

        //----------Bind Data Grid-----------------
        public void bindgrid(string sortExpression = null)
        {

            try
            {
                string Condition = "";

                if (currentSortColumn.ToString() != "")
                    Condition = Condition + currentSortColumn + " ";

                if (currentSortColumn.ToString() != "" && currentSortOrder.ToString() == "ASC")
                    Condition = Condition + " asc  ";
                else if (currentSortColumn.ToString() != "" && currentSortOrder.ToString() == "DESC")
                    Condition = Condition + " desc  ";

                //-------------Bind Data Grid-----------------
                // string qry = " Select a.cerpac_no,(a.forename+' '+a.surname)as Name,b.FORMNO,a.people_id,  (Case when a.cerpac_no=b.FORMNO then 'Fresh Case' Else 'Renewal Case' End) as Status from People as a , PeopleChild as b,CerpacNo_Out_One as c,UserZoneRelation as d where a.cerpac_no = b.CerpacNo and b.CerpacNo=c.cerpac_no and b.FORMNO=c.cerpac_file_no and c.ZoneCode=d.ZoneCode and b.IsVerified=1 and (b.IsAuthorized=0 or b.IsAuthorized is null) and d.UserId=" + dt_login_details.Rows[0]["UserId"].ToString() + "";
                // string qry = " Select A.cerpac_no, (A.forename+' '+A.surname)as Name, A.cerpac_file_no as FORMNO, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) as Status   from vw_ApplicantDetails A, vw_ApplicantDocument B where A.cerpac_file_no=B.Form_No and isnull(A.IsAuthorized,0)=0   " +
                //    " group by A.cerpac_no, (A.forename+' '+A.surname) , A.cerpac_file_no, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) ";
                string qry = "";
                if (Condition != String.Empty)
                {
                    qry = " Select  A.cerpac_no, (A.forename+' '+A.surname)as Name, A.cerpac_file_no as FORMNO, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) as Status   " +
                       " from vw_ApplicantDetails A LEFT OUTER JOIN vw_ApplicantDocument B ON A.cerpac_file_no=B.Form_No where isnull(A.IsAuthorized,'0')='1' and isnull(ISARCR,'0')='1' and isnull(IsProduced,'0')='2'  and isnull(isLevel4,'0')='0'  group by  A.CreatedOn, A.cerpac_no, (A.forename+' '+A.surname) , A.cerpac_file_no, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) " +
                       " order by " + Condition + "  ";
                }
                else
                {
                    qry = " Select  A.cerpac_no, (A.forename+' '+A.surname)as Name, A.cerpac_file_no as FORMNO, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) as Status   " +
                     " from vw_ApplicantDetails A LEFT OUTER JOIN vw_ApplicantDocument B ON A.cerpac_file_no=B.Form_No where isnull(A.IsAuthorized,'0')=1 and isnull(ISARCR,'0')='1' and isnull(IsProduced,'0')='2'  and isnull(isLevel4,'0')='0'  group by  A.CreatedOn, A.cerpac_no, (A.forename+' '+A.surname) , A.cerpac_file_no, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) " +
                    " order by   A.CreatedOn desc ";

                }
                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(qry);

                if (dt.Rows.Count > 0)
                {
                    Session["GridViewCG"] = dt;
                    //lbl_total.Text = dt.Rows.Count.ToString();
                    GridViewCG.DataSource = dt;
                    GridViewCG.DataBind();
                }
                else
                {
                    //lbl_total.Text = dt.Rows.Count.ToString();
                    GridViewCG.DataSource = null;
                    GridViewCG.DataBind();
                }




            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }
        }



        protected void lnkNormal_Click(object sender, EventArgs e)
        {
            if (sender is LinkButton)
            {
                LinkButton linkButton = (LinkButton)sender;
                string newSortColumn = linkButton.CommandArgument;


                if (currentSortColumn == newSortColumn)
                {
                    currentSortOrder = currentSortOrder == "ASC" ? "DESC" : "ASC";
                }
                else
                {
                    currentSortColumn = newSortColumn;
                    currentSortOrder = "ASC";
                }

                GridViewCG.SelectedIndex = -1;
                bindgrid();
                grdLevel3flag = "1";
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            //ViewState["SortOrder"] = currentSortOrder;
            //ViewState["SortColumn"] = currentSortColumn;

            //Position(grdLevel3, (App_Code.SortOrder)currentSortOrder, currentSortColumn);
            //Position(grdLostCard, (App_Code.SortOrder)currentSortOrder, currentSortColumn);
            App_Code.SortOrder sortOrder;
            if (currentSortOrder.ToLower() == "asc")
            {
                sortOrder = App_Code.SortOrder.asc;
            }
            else
            {
                sortOrder = App_Code.SortOrder.desc;
            }

            if (grdLevel3flag == "1")
                Position(GridViewCG, sortOrder, currentSortColumn);
            else
                Position(GridViewCG, sortOrder, currentSortColumn);
        }

        private void Position(GridView gridView, App_Code.SortOrder currentSortOrder, string currentSortColumn)
        {
            if ((gridView.Rows.Count == 0) || (string.IsNullOrEmpty(currentSortColumn)))
                return;

            System.Web.UI.WebControls.Image glyph = new System.Web.UI.WebControls.Image();

            glyph.EnableTheming = false;

            if (currentSortOrder == App_Code.SortOrder.asc)
                glyph.ImageUrl = "~/eImage_files/Up_Arrow.png";

            else
                glyph.ImageUrl = "~/eImage_files/down_arrow.png";

            for (int x = 0; x < gridView.Columns.Count; x++)
            {
                if (string.Compare(currentSortColumn, gridView.Columns[x].SortExpression, true) == 0)
                {
                    gridView.HeaderRow.Cells[x].Controls.Add(glyph);
                    break;
                }
            }
        }



        protected void GridViewCG_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewCG.PageIndex = e.NewPageIndex;
            this.bindgrid();

        }

        protected void GridViewCG_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    int serialNo = e.Row.RowIndex + 1; // Generate serial number (1-based index)
                    Label lblSerialNo = (Label)e.Row.FindControl("lblSerialNo");
                    if (lblSerialNo != null)
                    {
                        lblSerialNo.Text = serialNo.ToString();
                    }

                    e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(GridViewCG, "Select$" + e.Row.RowIndex);
                    e.Row.Attributes["style"] = "cursor:pointer";
                }
            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }

        }

        protected void GridViewCG_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                //Reference the GridView Row.
                GridViewRow row = GridViewCG.Rows[rowIndex];
            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }
        }

        protected void GridViewCG_SelectedIndexChanged(object sender, EventArgs e)
        {

            try
            {
                Label lblCerpacNo = (Label)GridViewCG.SelectedRow.FindControl("lblCerpacNo");
                //string qry = "select a.*,b.* from People as a , PeopleChild as b where a.cerpac_no = b.CerpacNo and a.cerpac_file_no=b.FORMNO and (b.IsAuthorized=0 or b.IsAuthorized IS NULL) and b.IsVerified=1 and a.cerpac_no='" + lblCerpacNo.Text.ToString().Trim() + "'";

                string Qty1 = "SELECT App_id, Title,people_id , Category_Type, tile1,forename,middle_name,surname,sex,cerpac_no,cerpac_file_no,cerpac_receipt_date , picture    ,cerpac_expiry_date,registration_area,registration_code,file_no,passport_no,nationality,passport_issue_date,passport_expiry_date " +
                    ",passport_issue_loc,passport_issue_by,date_of_birth,place_of_birth,nigeria_add_1,nigeria_add_2,nigeria_tel_no,abroad_add_1     ,abroad_add_2,abroad_tel_no,company,company_add_1,company_add_2,designation,employment_date,company_tel_no,company_fax_no " +
                    ",email,verid_template,ContactNo,userImage,IsVerified,IsAuthorized,IsProduced,VerifiedBy,AuthorizedBy,ProducedBy     ,ProducedOn,AuthorizedOn,VerifiedOn,IsRejected,RejectedBy,RejectedOn,RejectionReason,ZoneNote,AuthNote,ProdNote,QualNote " +
                    ",IsDependent,DesignationCode,DependentOn,ISARCR,ConfirmedBy,ConfirmedOn,Cerpac_ExpiryDt,Cerpac_IssuedDt,IsQual,QualBy,QualOn,CompanyName    , convert(varchar(10), date_system_modified ,103) as date_system_modified, AppType,MaritalStatus,PaymentMode1 " +
                    " FROM vw_ApplicantDetails where cerpac_no='" + lblCerpacNo.Text.ToString().Trim() + "'";
                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(Qty1);
                string Cerpac = "", FormNo = "";
                if (dt.Rows.Count > 0)
                {
                    //----User Images---------------
                    if ((dt.Rows[0]["userimage"].ToString()) != "")
                    {
                        byte[] imagem = (byte[])(dt.Rows[0]["userimage"]);
                        string PROFILE_PIC = Convert.ToBase64String(imagem);
                        ImgPhoto.ImageUrl = String.Format("data:image/jpg;base64,{0}", PROFILE_PIC);

                    }
                    else
                    {
                        string imgPath1 = "~/eImage_files/default_logo.gif";
                        ImgPhoto.ImageUrl = "~/" + imgPath1;

                    }

                    ViewState["App_id"] = dt.Rows[0]["App_id"].ToString().Trim();


                    Cerpac = dt.Rows[0]["cerpac_no"].ToString().Trim();
                    ViewState["Cerpac"] = Cerpac;

                    FormNo = dt.Rows[0]["cerpac_file_no"].ToString().Trim();
                    ViewState["FormNo"] = FormNo;
                    lblCategory.Text = dt.Rows[0]["Category_Type"].ToString().Trim();
                    lblCIssueDate.Text = dt.Rows[0]["cerpac_receipt_date"].ToString().Trim();
                    lblCExpiryDate.Text = dt.Rows[0]["cerpac_expiry_date"].ToString().Trim();

                    lblCerpacNo1.Text = dt.Rows[0]["cerpac_no"].ToString().Trim();
                    /***********CERPAC Details************************/
                    lblCCerpacNo.Text = dt.Rows[0]["cerpac_no"].ToString().Trim();
                    lblCBankFromNo.Text = dt.Rows[0]["cerpac_file_no"].ToString().Trim();
                    // lblCDOI.Text = dt.Rows[0]["cerpac_receipt_date"].ToString().Trim();
                    // lblCDOE.Text = dt.Rows[0]["cerpac_expiry_date"].ToString().Trim();


                    //txtIssuedate.Text = CommonFunctions.ConvertToDateStringFormat(dt.Rows[0]["cerpac_receipt_date"]).ToString().Trim();
                    // txtIssuedate.Text = string.Format("{0:d-MM-yyyy}", dt.Rows[0]["cerpac_receipt_date"]).ToString().Trim();
                    //DateTime cerpacReceiptDate = Convert.ToDateTime(dt.Rows[0]["cerpac_receipt_date"]);                    
                    //txtIssuedate.Text = cerpacReceiptDate.ToString("yyyy-MM-dd").Trim();
                    //// txtExpirydate.Text = string.Format("{0:d-MM-yyyy}", dt.Rows[0]["cerpac_expiry_date"]).ToString().Trim();
                    //DateTime cerpacExpiryDate = Convert.ToDateTime(dt.Rows[0]["cerpac_expiry_date"]);

                    //// Format the DateTime to the desired string format
                    //txtExpirydate.Text = cerpacExpiryDate.ToString("yyyy-MM-dd").Trim();



                    DateTime cerpacReceiptDate = Convert.ToDateTime(dt.Rows[0]["cerpac_receipt_date"]);

                    // Format the DateTime to the desired string format
                    txtIssuedate.Text = cerpacReceiptDate.ToString("yyyy-MM-dd").Trim();
                    //  txtIssuedate.Text = string.Format("{0:yyyy-MM-dd}", dt.Rows[0]["cerpac_receipt_date"]).ToString().Trim();

                    //CommonFunctions.ConvertToDateStringFormat(dt.Rows[0]["cerpac_receipt_date"]).ToString().Trim();

                    DateTime cerpacExpiryDate = Convert.ToDateTime(dt.Rows[0]["cerpac_expiry_date"]);

                    // Format the DateTime to the desired string format
                    txtExpirydate.Text = cerpacExpiryDate.ToString("yyyy-MM-dd").Trim();
                    /***********Personal Details************************/
                    lblTitle.Text = dt.Rows[0]["title"].ToString().Trim();
                    lblFristName.Text = dt.Rows[0]["forename"].ToString().Trim();
                    lblLastName.Text = dt.Rows[0]["surname"].ToString().Trim();

                    HlblTitle.Text = dt.Rows[0]["title"].ToString().Trim();
                    HlblFristName.Text = dt.Rows[0]["forename"].ToString().Trim();
                    HlblLastName.Text = dt.Rows[0]["surname"].ToString().Trim();
                    lblSubmissionDate.Text = dt.Rows[0]["date_system_modified"].ToString().Trim();
                    lblApplicantType.Text = dt.Rows[0]["AppType"].ToString().Trim();


                    lblDOB.Text = dt.Rows[0]["date_of_birth"].ToString().Trim();
                    lblSex.Text = dt.Rows[0]["sex"].ToString().Trim();
                    lblPaymentMode.Text = dt.Rows[0]["PaymentMode1"].ToString().Trim();
                    lblMaritalStatus.Text = dt.Rows[0]["MaritalStatus"].ToString().Trim();
                    lblNationality.Text = dt.Rows[0]["nationality"].ToString().Trim();
                    lblPOB.Text = dt.Rows[0]["place_of_birth"].ToString().Trim();
                    lblemailId.Text = dt.Rows[0]["email"].ToString().Trim();
                    lblContactNo.Text = dt.Rows[0]["ContactNo"].ToString().Trim();
                    lblAddress1.Text = dt.Rows[0]["abroad_add_1"].ToString().Trim();
                    lblAddress2.Text = dt.Rows[0]["abroad_add_2"].ToString().Trim();



                    /***********Passport Details************************/
                    lblPassportNo.Text = dt.Rows[0]["passport_no"].ToString().Trim();
                    lblPlaceOfIssue.Text = dt.Rows[0]["passport_issue_loc"].ToString().Trim();
                    lblPassportIssuedBy.Text = dt.Rows[0]["passport_issue_by"].ToString().Trim();
                    lblPassportIssueDate.Text = dt.Rows[0]["passport_issue_date"].ToString().Trim();
                    lblPassportExpiryDate.Text = dt.Rows[0]["passport_expiry_date"].ToString().Trim();

                    /***********Company Address Details************************/
                    lblCompanyRC.Text = dt.Rows[0]["company"].ToString().Trim();
                    lblCompanyName.Text = dt.Rows[0]["CompanyName"].ToString().Trim();
                    lblComAddress1.Text = dt.Rows[0]["company_add_1"].ToString().Trim();
                    lblComAddress2.Text = dt.Rows[0]["company_add_2"].ToString().Trim();
                    lblDesignation.Text = dt.Rows[0]["designation"].ToString().Trim();
                    lblComTelephone.Text = dt.Rows[0]["company_tel_no"].ToString().Trim();
                    lblComFaxNo.Text = dt.Rows[0]["company_fax_no"].ToString().Trim();
                    lblEmploymentDt.Text = dt.Rows[0]["employment_date"].ToString().Trim();


                    //-------------L2 commit need to display---------------


                    string Qty3 = "Select A.AuthNote, B.Username from peoplechild A, usermaster B where A.AuthorizedBy=B.UserID and A.Cerpacno ='" + lblCerpacNo.Text.ToString().Trim() + "' " +
                        " and A.formno='" + FormNo.ToString().Trim() + "' and isAuthorized=1";

                    string Qty4 = "Select A.ZoneNote, B.Username from peoplechild A, usermaster B where A.ConfirmedBy=B.UserID and A.Cerpacno ='" + lblCerpacNo.Text.ToString().Trim() + "' " +
                        " and A.formno='" + FormNo.ToString().Trim() + "' and ISARCR=1";

                    string Qty5 = "Select A.ProdNote, B.Username from peoplechild A, usermaster B where A.ProducedBy=B.UserID and A.Cerpacno ='" + lblCerpacNo.Text.ToString().Trim() + "' " +
                      " and A.formno='" + FormNo.ToString().Trim() + "' and IsProduced=2";

                    DataTable DtC = new DataTable();
                    DtC = CommonFunctions.fetchdata(Qty3);

                    if (DtC.Rows.Count > 0)
                    {
                        lblNameL1.Text = DtC.Rows[0]["Username"].ToString().Trim();
                        lblCommetL1.Text = DtC.Rows[0]["AuthNote"].ToString().Trim();
                    }
                    DataTable DtZ = new DataTable();
                    DtZ = CommonFunctions.fetchdata(Qty4);

                    if (DtZ.Rows.Count > 0)
                    {
                        lblNameL2.Text = DtZ.Rows[0]["Username"].ToString().Trim();
                        lblCommetL2.Text = DtZ.Rows[0]["ZoneNote"].ToString().Trim();
                    }

                    DataTable DtP = new DataTable();
                    DtP = CommonFunctions.fetchdata(Qty5);

                    if (DtP.Rows.Count > 0)
                    {
                        lblNameL3.Text = DtP.Rows[0]["Username"].ToString().Trim();
                        lblCommetL3.Text = DtP.Rows[0]["ProdNote"].ToString().Trim();
                    }


                    BindComments();


                    pnlMain.Attributes.Add("style", "display:none;"); ;
                    pnldisplay.Attributes.Add("style", "display:block;");
                }


                String Qty2 = "Select EducationLevel,InstitutionName, FieldOfStudy, IsCompleted, year(CompletedOn) as DegreeCompletedOn  from tbl_eCerpac_Applicant_Education_Dtl where Form_No  ='" + FormNo.ToString().Trim() + "'";
                DataTable dte = new DataTable();
                dte = CommonFunctions.fetchdata(Qty2);

                if (dte.Rows.Count > 0)
                {
                    /***********Eduction Details ************************/
                    lblDegree.Text = dte.Rows[0]["EducationLevel"].ToString().Trim();
                    lblInstitutionName.Text = dte.Rows[0]["InstitutionName"].ToString().Trim();
                    lblYearGraduation.Text = dte.Rows[0]["DegreeCompletedOn"].ToString().Trim();
                }

                if (FormNo != string.Empty)
                {
                    string Qty = "";

                    //Personal Doc
                    Qty = "  Select row_number() over( order by (select null)) [SLNo], T1.App_Id, T1.Form_No, T1.IsValidated, T3.DocName, T4.Doc_Tab_Name, T2.Doc_Number, T1.App_DocImage as Doc_Image, T2.Doc_IssueDate, T2.Doc_ExpiryDate from [dbo].[tbl_eCerpac_Applicant_Document] T1 LEFT OUTER JOIN tbl_eCerpac_ApplicantDocumentDetails T2 on T1.App_id = T2.App_id and T1.Doc_Id = T2.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocumentType] T3 on T1.Doc_id = T3.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocType_Tab] T4 on T3.Doc_Tab = T4.Doc_Tab " +
                       " Where  T1.Form_No = '" + FormNo + "' and T4.Doc_Tab_Name ='Personal Document' ";

                    DataTable dtD = new DataTable();
                    dtD = CommonFunctions.fetchdata(Qty);

                    if (dtD.Rows.Count > 0)
                    {
                        if (dtD.Rows.Count > 0 && dtD.Rows[0]["Doc_Tab_Name"].ToString().Trim() == "Personal Document")
                        {
                            Session["gdPImage"] = dtD;
                            //lbl_total.Text = dt.Rows.Count.ToString();
                            gdPImage.DataSource = dtD;
                            gdPImage.DataBind();
                        }
                        else
                        {
                            //lbl_total.Text = dt.Rows.Count.ToString();
                            gdPImage.DataSource = null;
                            gdPImage.DataBind();
                        }

                    }

                    //Passport Doc
                    Qty = "  Select row_number() over( order by (select null)) [SLNo], T1.App_Id, T1.Form_No,T1.IsValidated, T3.DocName, T4.Doc_Tab_Name, T2.Doc_Number, T1.App_DocImage as Doc_Image, T2.Doc_IssueDate, T2.Doc_ExpiryDate from [dbo].[tbl_eCerpac_Applicant_Document] T1 LEFT OUTER JOIN tbl_eCerpac_ApplicantDocumentDetails T2 on T1.App_id = T2.App_id and T1.Doc_Id = T2.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocumentType] T3 on T1.Doc_id = T3.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocType_Tab] T4 on T3.Doc_Tab = T4.Doc_Tab " +
                        " Where  T1.Form_No = '" + FormNo + "' and T4.Doc_Tab_Name ='Arrival Document' ";

                    DataTable dtA = new DataTable();
                    dtA = CommonFunctions.fetchdata(Qty);


                    if (dtA.Rows.Count > 0 && dtA.Rows[0]["Doc_Tab_Name"].ToString().Trim() == "Arrival Document")
                    {
                        Session["gdAImage"] = dtD;
                        //lbl_total.Text = dt.Rows.Count.ToString();
                        gdAImage.DataSource = dtA;
                        gdAImage.DataBind();
                    }
                    else
                    {
                        //lbl_total.Text = dt.Rows.Count.ToString();
                        gdAImage.DataSource = null;
                        gdAImage.DataBind();
                    }


                    //Eduction Doc
                    Qty = "  Select row_number() over( order by (select null)) [SLNo], T1.App_Id, T1.Form_No,  T1.IsValidated, T3.DocName, T4.Doc_Tab_Name, T2.Doc_Number, T1.App_DocImage as Doc_Image, T2.Doc_IssueDate, T2.Doc_ExpiryDate from [dbo].[tbl_eCerpac_Applicant_Document] T1 LEFT OUTER JOIN tbl_eCerpac_ApplicantDocumentDetails T2 on T1.App_id = T2.App_id and T1.Doc_Id = T2.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocumentType] T3 on T1.Doc_id = T3.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocType_Tab] T4 on T3.Doc_Tab = T4.Doc_Tab " +
                      " Where  T1.Form_No = '" + FormNo + "' and T4.Doc_Tab_Name ='Education Document' ";

                    DataTable dtE = new DataTable();
                    dtE = CommonFunctions.fetchdata(Qty);


                    if (dtE.Rows.Count > 0 && dtE.Rows[0]["Doc_Tab_Name"].ToString().Trim() == "Education Document")
                    {
                        Session["gdEImage"] = dtE;
                        //lbl_total.Text = dt.Rows.Count.ToString();
                        gdEImage.DataSource = dtE;
                        gdEImage.DataBind();
                    }
                    else
                    {
                        //lbl_total.Text = dt.Rows.Count.ToString();
                        gdEImage.DataSource = null;
                        gdEImage.DataBind();
                    }

                    //CompanyRelated Doc
                    Qty = "  Select row_number() over( order by (select null)) [SLNo], T1.App_Id, T1.Form_No, T1.IsValidated, T3.DocName, T4.Doc_Tab_Name, T2.Doc_Number, T1.App_DocImage as Doc_Image, T2.Doc_IssueDate, T2.Doc_ExpiryDate from [dbo].[tbl_eCerpac_Applicant_Document] T1 LEFT OUTER JOIN tbl_eCerpac_ApplicantDocumentDetails T2 on T1.App_id = T2.App_id and T1.Doc_Id = T2.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocumentType] T3 on T1.Doc_id = T3.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocType_Tab] T4 on T3.Doc_Tab = T4.Doc_Tab " +
                       " Where  T1.Form_No = '" + FormNo + "' and T4.Doc_Tab_Name ='Organization Document' ";

                    DataTable dtCom = new DataTable();
                    dtCom = CommonFunctions.fetchdata(Qty);


                    if (dtCom.Rows.Count > 0 && dtCom.Rows[0]["Doc_Tab_Name"].ToString().Trim() == "Organization Document")
                    {
                        Session["gdQrgImage"] = dtCom;
                        //lbl_total.Text = dt.Rows.Count.ToString();
                        gdQrgImage.DataSource = dtCom;
                        gdQrgImage.DataBind();
                    }
                    else
                    {
                        //lbl_total.Text = dt.Rows.Count.ToString();
                        gdEImage.DataSource = null;
                        gdEImage.DataBind();
                    }
                }

            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }
        }

        protected void Go_Click(object sender, EventArgs e)
        {
            try
            {


                // string qry = "  Select A.cerpac_no, (A.forename+' '+A.surname)as Name, A.cerpac_file_no as FORMNO, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) as Status   from vw_ApplicantDetails A, vw_ApplicantDocument B where A.cerpac_file_no=B.Form_No and isnull(A.IsAuthorized,0)=0      and ( A.cerpac_no='" + TextAppId.Text.ToString() + "' or A.cerpac_file_no='" + TextAppId.Text.ToString() + "' ) " +
                //     "  and A.IsProduced=0 group by A.cerpac_no, (A.forename+' '+A.surname) , A.cerpac_file_no,(Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End)  ";

                string qry = " Select  A.cerpac_no, (A.forename+' '+A.surname)as Name, A.cerpac_file_no as FORMNO, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) as Status   " +
                " from vw_ApplicantDetails A LEFT OUTER JOIN vw_ApplicantDocument B ON A.cerpac_file_no=B.Form_No where isnull(A.IsAuthorized,0)=1 and isnull(ISARCR,0)=1 and isnull(IsProduced,0)=2  and isnull(isLevel4,0)=0  and ( A.cerpac_no like '" + TextAppId.Text.ToString() + "%' or A.cerpac_file_no like '" + TextAppId.Text.ToString() + "%' ) " +
                " group by  A.CreatedOn, A.cerpac_no, (A.forename+' '+A.surname) , A.cerpac_file_no, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) " +
                " order by A.CreatedOn desc ";


                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(qry);

                if (dt.Rows.Count > 0)
                {
                    Session["GridViewCard"] = dt;
                    //lbl_total.Text = dt.Rows.Count.ToString();
                    GridViewCG.DataSource = dt;
                    GridViewCG.DataBind();
                }
                else
                {
                    //lbl_total.Text = dt.Rows.Count.ToString();
                    GridViewCG.DataSource = null;
                    GridViewCG.DataBind();
                }

                //pnlMain.Attributes.Add("style", "display:block;");
                //pnlAddDiv.Attributes.Add("style", "display:none;");
                //pnlViewDiv.Attributes.Add("style", "display:none;");
                //pnlEdit.Attributes.Add("style", "display:none;");

            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }
        }

        protected void btnApproved_Click(object sender, EventArgs e)
        {


            try
            {
                int x = CalDate();
                if (x == 0)
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;
                    cmd.CommandText = "sp_eCerpac_FinalCgLevel4";
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@App_id", ViewState["App_id"].ToString().Trim());
                    cmd.Parameters.AddWithValue("@Formno", lblCBankFromNo.Text.ToString().Trim());
                    cmd.Parameters.AddWithValue("@cerpacno", lblCerpacNo1.Text.ToString().Trim());
                    cmd.Parameters.AddWithValue("@UserId", dt_login_details.Rows[0]["Userid"].ToString());
                    cmd.Parameters.AddWithValue("@CGnotes", Textarea1.Value.Trim());
                    cmd.Parameters.AddWithValue("@Flag", "CardApproved");
                    SqlParameter output = new SqlParameter("@SuccessId", SqlDbType.Int);
                    output.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(output);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    String R = output.Value.ToString();
                    con.Close();


                    if (R != String.Empty)
                    {
                        //  SendMail();

                        pnlMain.Attributes.Add("style", "display:none;"); ;
                        pnldisplay.Attributes.Add("style", "display:none;");
                        pnlCard.Attributes.Add("style", "display:none;");
                        pnlmsg.Attributes.Add("style", "display:block;");
                        pnlmsgCorrection.Attributes.Add("style", "display:none;");
                        pnlRejection.Attributes.Add("style", "display:none;");
                        pnlReferBack.Attributes.Add("style", "display:none;");
                    }
                    else
                    {
                        lblloginmsg.Attributes.Add("class", "active");
                        lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                        lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Server connectivity problem !" + " </h4>";
                    }
                }
                else
                {
                    lblloginmsg.Attributes.Add("class", "active");
                    lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                    lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " eCERRPAC card issue and expiry date calculation problem !" + " </h4>";
                }
            }
            catch (Exception ex)
            {
                throw (ex);
            }


        }



        protected void gdEImage_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int genderValue = (int)DataBinder.Eval(e.Row.DataItem, "IsValidated");
                if ((genderValue) > 0)
                {
                    RadioButtonList rb = (RadioButtonList)e.Row.FindControl("RadioButtonList1");
                    rb.Items.FindByValue(genderValue.ToString()).Selected = true;
                    rb.Enabled = false;
                }
            }
        }

        protected void gdQrgImage_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int genderValue = (int)DataBinder.Eval(e.Row.DataItem, "IsValidated");
                if ((genderValue) > 0)
                {
                    RadioButtonList rb = (RadioButtonList)e.Row.FindControl("RadioButtonList1");
                    rb.Items.FindByValue(genderValue.ToString()).Selected = true;
                    rb.Enabled = false;
                }
            }

        }

        protected void gdAImage_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int genderValue = (int)DataBinder.Eval(e.Row.DataItem, "IsValidated");
                if ((genderValue) > 0)
                {
                    RadioButtonList rb = (RadioButtonList)e.Row.FindControl("RadioButtonList1");
                    rb.Items.FindByValue(genderValue.ToString()).Selected = true;
                    rb.Enabled = false;
                }
            }
        }

        protected void gdPImage_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int genderValue = (int)DataBinder.Eval(e.Row.DataItem, "IsValidated");
                if ((genderValue) > 0)
                {
                    RadioButtonList rb = (RadioButtonList)e.Row.FindControl("RadioButtonList1");
                    rb.Items.FindByValue(genderValue.ToString()).Selected = true;
                    rb.Enabled = false;
                }
            }

        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            pnlMain.Attributes.Add("style", "display:block;"); ;
            pnldisplay.Attributes.Add("style", "display:none;");
            pnlCard.Attributes.Add("style", "display:none;");
        }

        private int CalDate()
        {
            DateTime d1 = Convert.ToDateTime(CommonFunctions.ConvertToDateStringFormat(txtIssuedate.Text.ToString()));
            DateTime d2 = Convert.ToDateTime(CommonFunctions.ConvertToDateStringFormat(txtExpirydate.Text.ToString()));
            string d3 = (d2 - d1).TotalDays.ToString();
            // Response.Write("<script>alert('" + d3.ToString() + "')</script>");
            if ((lblCerpacNo1.Text.ToString().ToUpper().Substring(0, 2) == "AO" || lblCerpacNo1.Text.ToString().ToUpper().Substring(0, 2) == "CR" || lblCerpacNo1.Text.ToString().ToUpper().Substring(0, 2) == "AB") && int.Parse(d3) >= 366)
            {
                Response.Write("<script>alert('Cerpac Expiry Date should be less than or equal to one year from issue date')</script>");
                return 1;
            }
            if ((lblCerpacNo1.Text.ToString().ToUpper().Substring(0, 2) == "AR" && int.Parse(d3) > 735) && (lblCompanyName.Text.ToUpper() != "NIGER WIFE" && lblDesignation.Text.ToUpper() != "NIGER WIFE"))
            {
                Response.Write("<script>alert('Cerpac Expiry Date for AR category should be less than or equal to two years from issue date')</script>");
                return 1;
            }
            if ((lblCerpacNo1.Text.ToString().ToUpper().Substring(0, 2) == "AR" && int.Parse(d3) > 735) && (lblCompanyName.Text.ToUpper() != "SPECIAL IMMIGRATION STATUS" && lblDesignation.Text.ToUpper() != "SPECIAL IMMIGRATION STATUS"))
            {
                Response.Write("<script>alert('Cerpac Expiry Date for AR category should be less than or equal to two years from issue date')</script>");
                return 1;
            }
            else
                return 0;

        }

        private async void SendMail()
        {


            //-------------------Configuration settings details-------------------      

            string send = ConfigurationManager.AppSettings["userName"].ToString();
            string senderPassword = ConfigurationManager.AppSettings["password"].ToString();
            string senderHost = ConfigurationManager.AppSettings["host"].ToString();
            int senderPort = Convert.ToInt16(ConfigurationManager.AppSettings["port"]);
            Boolean isSSL = Convert.ToBoolean(ConfigurationManager.AppSettings["enableSsl"]);

            //-------------------Get Applicant details-------------------      
            string Email = "", txtName = "";
            string qry = "SELECT Title,people_id ,tile1,forename,middle_name,surname,sex,cerpac_no,cerpac_file_no,cerpac_receipt_date , picture    ,cerpac_expiry_date,registration_area,registration_code,file_no,passport_no,nationality,passport_issue_date,passport_expiry_date " +
                               ",passport_issue_loc,passport_issue_by,date_of_birth,place_of_birth,nigeria_add_1,nigeria_add_2,nigeria_tel_no,abroad_add_1     ,abroad_add_2,abroad_tel_no,company,company_add_1,company_add_2,designation,employment_date,company_tel_no,company_fax_no " +
                               ",email,verid_template,ContactNo,userImage,IsVerified,IsAuthorized,IsProduced,VerifiedBy,AuthorizedBy,ProducedBy     ,ProducedOn,AuthorizedOn,VerifiedOn,IsRejected,RejectedBy,RejectedOn,RejectionReason,ZoneNote,AuthNote,ProdNote,QualNote " +
                               ",IsDependent,DesignationCode,DependentOn,ISARCR,ConfirmedBy,ConfirmedOn,Cerpac_ExpiryDt,Cerpac_IssuedDt,IsQual,QualBy,QualOn,CompanyName    ,date_system_modified " +
                               " FROM vw_ApplicantDetails where cerpac_no='" + ViewState["Cerpac"].ToString().Trim() + "' and cerpac_file_no='" + ViewState["FormNo"].ToString().Trim() + "'";



            DataTable dt = new DataTable();
            dt = CommonFunctions.fetchdata(qry);

            if (dt.Rows.Count > 0)
            {
                //------------------------Card Data---------------

                string ApplicationId = dt.Rows[0]["cerpac_no"].ToString();

                //----User Images---------------
                if ((dt.Rows[0]["userimage"].ToString()) != "")
                {
                    byte[] imagem = (byte[])(dt.Rows[0]["userimage"]);
                    string PROFILE_PIC = Convert.ToBase64String(imagem);
                    Image1.ImageUrl = String.Format("data:image/jpg;base64,{0}", PROFILE_PIC);

                }
                else
                {
                    string imgPath1 = "~/eImage_files/default_logo.gif";
                    Image1.ImageUrl = "~/" + imgPath1;
                }



                lbl_name.Text = ((dt.Rows[0]["forename"].ToString() + " " + dt.Rows[0]["surname"].ToString()).ToLower());
                lbl_passport.Text = dt.Rows[0]["passport_no"].ToString().ToUpper();
                txt_comps.Text = dt.Rows[0]["CompanyName"].ToString().ToUpper();
                lbl_desig.Text = ((dt.Rows[0]["designation"].ToString()).ToLower());
                lbl_dob.Text = string.Format("{0:d-MM-yyyy}", dt.Rows[0]["date_of_birth"]).ToString().Trim();

                lbl_nationality.Text = ((dt.Rows[0]["nationality"].ToString()).ToUpper());
                lbl_date_of_issue.Text = string.Format("{0:d-MM-yyyy}", dt.Rows[0]["cerpac_receipt_date"]).ToString().Trim();
                lbl_expiry_date.Text = string.Format("{0:d-MM-yyyy}", dt.Rows[0]["cerpac_expiry_date"]).ToString();

                String cer_no = dt.Rows[0]["cerpac_no"].ToString().Substring(0, 1).ToUpper() + dt.Rows[0]["cerpac_no"].ToString().Substring(1);
                lbl_cerpac_no.Text = dt.Rows[0]["cerpac_no"].ToString().ToUpper();
                lbl_cerpac_file_no.Text = dt.Rows[0]["cerpac_file_no"].ToString().ToUpper();
                GenerateCode(dt.Rows[0]["passport_no"].ToString().ToUpper(), dt.Rows[0]["forename"].ToString() + " " + dt.Rows[0]["surname"].ToString(), string.Format("{0:d-MM-yyyy}", dt.Rows[0]["date_of_birth"]).ToString().Trim(), string.Format("{0:d-MM-yyyy}", dt.Rows[0]["cerpac_receipt_date"]).ToString().Trim(), string.Format("{0:d-MM-yyyy}", dt.Rows[0]["cerpac_expiry_date"]).ToString().Trim(),
                    dt.Rows[0]["CompanyName"].ToString().ToUpper(), dt.Rows[0]["cerpac_no"].ToString().ToUpper(), dt.Rows[0]["designation"].ToString().ToUpper());


                //--------------Get Signature--------------------

                string AuthSign = "SELECT AuthorizedBy from ProdReportCerpacCard where cerpacno='" + lbl_cerpac_no.Text.Trim() + "' and cerpac_file_no='" + lbl_cerpac_file_no.Text.Trim() + "'";

                DataTable ADt = new DataTable();
                ADt = CommonFunctions.fetchdata(AuthSign);
                if (ADt.Rows.Count > 0)
                {
                    string QSign = "select * from UserMaster where userid='" + ADt.Rows[0]["AuthorizedBy"].ToString() + "'";
                    DataTable QDt = new DataTable();
                    QDt = CommonFunctions.fetchdata(QSign);
                    if (QDt.Rows.Count > 0)
                    {
                        byte[] picData = QDt.Rows[0]["usersig"] as byte[] ?? null;
                        System.Drawing.Image newImage;
                        if (picData != null)
                        {
                            using (MemoryStream ms = new MemoryStream(picData))
                            {

                                Bitmap img = (Bitmap)System.Drawing.Image.FromStream(ms);
                                newImage = System.Drawing.Image.FromStream(ms);

                                //  if (!File.Exists(Server.MapPath("~") + "/Images/sign/sig.jpg"))
                                newImage.Save(Server.MapPath("~") + "/Images/sign.png");
                                // newImage.Save("g:/Saurabh" + Dt.Rows[0]["picture"].ToString().Trim());

                                Bitmap tempImage = new Bitmap(Server.MapPath("~") + "/Images/sign.png");
                                tempImage.MakeTransparent();
                                tempImage.Save(Server.MapPath("~") + "/Images/sign.png");
                            }

                            img_sign.ImageUrl = "~/Images/sign1.png";
                        }

                    }
                }



                //---------------------------------

                txtName = dt.Rows[0]["Title"].ToString() + " " + dt.Rows[0]["forename"].ToString() + " " + dt.Rows[0]["surname"].ToString();
                Email = dt.Rows[0]["email"].ToString();

                //-------------------Get Mail Formate details-------------------      
                string body = string.Empty;

                //// qry = "Select Subject, Title, Header, Body, Footer ,Opt from tbl_MailTempMaster W, tbl_FormMaster F where W.FormID = F.FormID and  F.formurl = '~/" + frmName.ToString() + "' and W.Opt='" + Opt.ToString() + "' ";
                //// DataTable dtM = new DataTable();
                //// dtM = fetchdata(qry);
                //// if (dtM.Rows.Count > 0)
                //int i = 0;
                //if (i == 0)
                //{


                //---------Read Teamplate and Pass data to teamplate string-------------
                //using streamreader for reading my htmltemplate   

                using (StreamReader reader = new StreamReader(HttpContext.Current.Server.MapPath("~/WebTemplate.html")))
                {
                    {
                        body = reader.ReadToEnd();
                    }
                    body = body.Replace("{UserName}", txtName); //replacing the required things  
                    body = body.Replace("{Title}", "Nigrian Immgration Service");
                    body = body.Replace("{Header}", "eCERPAC");
                    body = body.Replace("{Body}", "Card Issued");
                    body = body.Replace("{message}", "Remark");
                    body = body.Replace("{footer}", "Regards");
                }


                string subject = "Nigeria Immigration Services";

                string base64 = Request.Form[hfImageData.UniqueID].Split(',')[1];
                byte[] bytes = Convert.FromBase64String(base64);

                //------------------Configure the Email Body----------------------------
                MailMessage msg = new MailMessage();
                msg.IsBodyHtml = true;
                msg.From = new MailAddress(send);
                msg.To.Add(Email.ToString());
                msg.Subject = subject;
                msg.Body = body;

                msg.Attachments.Add(new Attachment(new MemoryStream(bytes), "eCERPAC_Digital_Card(" + lbl_cerpac_no.Text.ToString().Trim() + ").png"));

                //---------------- Create a SMTP server to send the email -------------------
                SmtpClient smtpServer = new SmtpClient();
                smtpServer.Host = senderHost;
                smtpServer.Port = senderPort;
                smtpServer.EnableSsl = isSSL;

                //------------------Passing the credentials of the user---------------------
                smtpServer.DeliveryMethod = SmtpDeliveryMethod.Network;
                NetworkCredential credentials = new NetworkCredential(send, senderPassword);
                smtpServer.Credentials = credentials;
                smtpServer.Send(msg);

            }


        }



        private void GenerateCode(string PassportNo, string name, string DOB, string cerpacIssue, string cerpacExpiry, string Company, string Cerpac, string Designation)
        {
            QrCodeEncodingOptions options = new QrCodeEncodingOptions()
            {
                CharacterSet = "UTF-8",
                DisableECI = true,
                Width = 250,
                Height = 250,
                Margin = 1
            };

            BarcodeWriter writer = new BarcodeWriter()
            {
                Format = BarcodeFormat.QR_CODE,
                Options = options
            };

            // var result = writer.Write("Applicant Name " + name + " Passport No." + PassportNo +" DOB" + DOB);
            var result = writer.Write("Applicant Name: " + name + "\neCerpac No.: " + Cerpac + "\nCompany Name.: " + Company + "\nDesignation: " + Designation + "\nPassport No.: " + PassportNo + "\nDOB: " + DOB + "\nCerpac Issue Date.: " + cerpacIssue + "\nCerpac Expiry Date: " + cerpacExpiry);



            if (!Directory.Exists(Server.MapPath("~/Images/QRImage"))) //n
            {
                // ScriptManager.RegisterStartupScript(this, GetType(), "alertScript", "swal('', 'No', 'success', {button: 'Ok', closeOnClickOutside: false})", true);
            }
            else
            {
                // ScriptManager.RegisterStartupScript(this, GetType(), "alertScript", "swal('', 'yes', 'error', {button: 'Ok', closeOnClickOutside: false})", true);
            }
            string path = Server.MapPath("~/Images/QRImage" + "TicketId" + Cerpac + ".jpg");
            var barcodeBitmap = new Bitmap(result);
            using (MemoryStream memory = new MemoryStream())
            {
                using (FileStream fs = new FileStream(path, FileMode.Create, FileAccess.ReadWrite))
                {
                    barcodeBitmap.Save(memory, ImageFormat.Jpeg);
                    byte[] bytes = memory.ToArray();
                    fs.Write(bytes, 0, bytes.Length);

                }

            }
            img_QRCode.Visible = true;
            img_QRCode.ImageUrl = "~/Images/QRImage" + "TicketId" + Cerpac + ".jpg";

        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            try
            {
                int x = CalDate();
                if (x == 0)
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;
                    cmd.CommandText = "sp_eCerpac_FinalCgLevel4";
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@App_id", ViewState["App_id"].ToString().Trim());
                    cmd.Parameters.AddWithValue("@Formno", lblCBankFromNo.Text.ToString().Trim());
                    cmd.Parameters.AddWithValue("@cerpacno", lblCerpacNo1.Text.ToString().Trim());
                    cmd.Parameters.AddWithValue("@UserId", dt_login_details.Rows[0]["Userid"].ToString());
                    cmd.Parameters.AddWithValue("@CGnotes", Textarea1.Value.Trim());
                    cmd.Parameters.AddWithValue("@Flag", "CardReject");
                    SqlParameter output = new SqlParameter("@SuccessId", SqlDbType.Int);
                    output.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(output);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    String R = output.Value.ToString();
                    con.Close();


                    if (R != String.Empty)
                    {
                        // SendMail();

                        pnlMain.Attributes.Add("style", "display:none;"); ;
                        pnldisplay.Attributes.Add("style", "display:none;");
                        pnlCard.Attributes.Add("style", "display:none;");
                        pnlmsg.Attributes.Add("style", "display:none;");
                        pnlmsgCorrection.Attributes.Add("style", "display:none;");
                        pnlReferBack.Attributes.Add("style", "display:none;");
                        pnlRejection.Attributes.Add("style", "display:block;");
                    }
                    else
                    {
                        lblloginmsg.Attributes.Add("class", "active");
                        lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                        lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Server connectivity problem !" + " </h4>";
                    }
                }
                else
                {
                    lblloginmsg.Attributes.Add("class", "active");
                    lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                    lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " eCERRPAC card issue and expiry date calculation problem !" + " </h4>";
                }
            }
            catch (Exception ex)
            {
                throw (ex);
            }

        }

        protected void btnReferBack_Click(object sender, EventArgs e)
        {
            try
            {
                int x = CalDate();
                if (x == 0)
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;
                    cmd.CommandText = "sp_eCerpac_FinalCgLevel4";
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@App_id", ViewState["App_id"].ToString().Trim());
                    cmd.Parameters.AddWithValue("@Formno", lblCBankFromNo.Text.ToString().Trim());
                    cmd.Parameters.AddWithValue("@cerpacno", lblCerpacNo1.Text.ToString().Trim());
                    cmd.Parameters.AddWithValue("@UserId", dt_login_details.Rows[0]["Userid"].ToString());
                    cmd.Parameters.AddWithValue("@CGnotes", Textarea1.Value.Trim());
                    cmd.Parameters.AddWithValue("@Flag", "Referback");
                    SqlParameter output = new SqlParameter("@SuccessId", SqlDbType.Int);
                    output.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(output);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    String R = output.Value.ToString();
                    con.Close();


                    if (R != String.Empty)
                    {
                        // SendMail();

                        pnlMain.Attributes.Add("style", "display:none;"); ;
                        pnldisplay.Attributes.Add("style", "display:none;");
                        pnlCard.Attributes.Add("style", "display:none;");
                        pnlmsg.Attributes.Add("style", "display:none;");
                        pnlmsgCorrection.Attributes.Add("style", "display:none;");
                        pnlRejection.Attributes.Add("style", "display:none;");
                        pnlReferBack.Attributes.Add("style", "display:block;");
                    }
                    else
                    {
                        lblloginmsg.Attributes.Add("class", "active");
                        lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                        lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Server connectivity problem !" + " </h4>";
                    }
                }
                else
                {
                    lblloginmsg.Attributes.Add("class", "active");
                    lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                    lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " eCERRPAC card issue and expiry date calculation problem !" + " </h4>";
                }
            }
            catch (Exception ex)
            {
                throw (ex);
            }
        }

        protected void commentList_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindComments();
            if (commentList.SelectedItem.Text == "Application Granted")
            {
                btnReferBack.Enabled = false;
                btnApproved.Enabled = true;
                btnReject.Enabled = false;
            }
            else if (commentList.SelectedItem.Text == "Application Rejected")
            {
                btnReferBack.Enabled = false;
                btnApproved.Enabled = false;
                btnReject.Enabled = true;
            }
            else
            {
                btnReferBack.Enabled = true;
                btnApproved.Enabled = false;
                btnReject.Enabled = false;
            }
        }
        public void BindComments()
        {
            string allComments = "select App_id,PassportNo,Level, UserName, Comments, CONVERT(VARCHAR, a.CreatedOn, 103) as date from tbl_eCerpac_NIS_CommentDetails a, UserMaster b where a.UserID=b.UserID and Form_No='" + ViewState["FormNo"].ToString() + "'";

            DataTable DtAllComments = new DataTable();
            DtAllComments = CommonFunctions.fetchdata(allComments);

            if (DtAllComments.Rows.Count > 0)
            {
                for (int i = 0; i < DtAllComments.Rows.Count; i++)
                {
                    // Create a new HtmlTableRow
                    HtmlTableRow row = new HtmlTableRow();

                    // Create the first cell
                    HtmlTableCell cell1 = new HtmlTableCell();


                    Label lblLevel = new Label { Text = DtAllComments.Rows[i]["Level"].ToString(), CssClass = "b99" };
                    cell1.Controls.Add(lblLevel);
                    cell1.Width = "10%";
                    row.Cells.Add(cell1);

                    // Create the second cell with a Label inside
                    HtmlTableCell cell2 = new HtmlTableCell();
                    Label lblName = new Label { Text = DtAllComments.Rows[i]["UserName"].ToString(), CssClass = "b99" };
                    cell2.Controls.Add(lblName);
                    cell2.Width = "20%";
                    row.Cells.Add(cell2);

                    // Create the third cell with another Label inside
                    HtmlTableCell cell3 = new HtmlTableCell();
                    Label lblComment = new Label { Text = DtAllComments.Rows[i]["Comments"].ToString(), CssClass = "b99" };
                    cell3.Controls.Add(lblComment);
                    cell3.Width = "50%";
                    row.Cells.Add(cell3);

                    HtmlTableCell cell4 = new HtmlTableCell();
                    Label lblDate = new Label { Text = DtAllComments.Rows[i]["date"].ToString(), CssClass = "b99" };
                    cell4.Controls.Add(lblDate);
                    cell4.Width = "20%";
                    row.Cells.Add(cell4);


                    // Add the row to the HtmlTable
                    tbl_comments.Rows.Add(row); // ✅ This will work if tblComments is an HtmlTable

                }
            }
        }
    }
}