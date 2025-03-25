using eCerpac_NIS.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;



namespace eCerpac_NIS
{
    public partial class frmAuthorizationProcess01: System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(CommonFunctions.connection.ToString());
        DataTable dt_login_details = new DataTable();

      //  string PassportNo = "", PlaceOfIssue = "", PassportIssuedBy = "", PassportIssueDate = "", PassportExpiryDate = "";
       // string CompanyRC = "", CompanyName = "", ComAddress1 = "", ComAddress2 = "", Designation = "", ComTelephone = "", ComFaxNo = "", EmploymentDt = "";
        // string Degree = "", InstitutionName = "", YearGraduation = "";


        //private SortOrder currentSortOrder;
        //private string currentSortColumn = "";
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
                    Server.Transfer("~/Login.aspx", false);
                }

                dt_login_details = (DataTable)Session["LoginDetails"];

                if (!IsPostBack)
                {
                    bindgrid();

                    pnlMain.Attributes.Add("style", "display:block;"); ;
                    pnldisplay.Attributes.Add("style", "display:none;");
                    pnlunCheckData.Attributes.Add("style", "display:none;");
                    pnlmsg.Attributes.Add("style", "display:none;");
                    pnlVConfirm.Attributes.Add("style", "display:none;");

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
                string Condition = "" ;

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
                string qry="";
                if (Condition != String.Empty )
                {
                    qry = " Select  A.cerpac_no, (A.forename+' '+A.surname)as Name, A.cerpac_file_no as FORMNO, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) as Status   " +
                       " from vw_ApplicantDetails A LEFT OUTER JOIN vw_ApplicantDocument B ON A.cerpac_file_no=B.Form_No where isnull(A.IsAuthorized,0)=0   group by  A.CreatedOn, A.cerpac_no, (A.forename+' '+A.surname) , A.cerpac_file_no, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) " +
                       " order by " + Condition + "  ";
                }
                else
                {
                    qry = " Select  A.cerpac_no, (A.forename+' '+A.surname)as Name, A.cerpac_file_no as FORMNO, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) as Status   " +
                     " from vw_ApplicantDetails A LEFT OUTER JOIN vw_ApplicantDocument B ON A.cerpac_file_no=B.Form_No where isnull(A.IsAuthorized,0)=0   group by  A.CreatedOn, A.cerpac_no, (A.forename+' '+A.surname) , A.cerpac_file_no, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) " +
                    " order by   A.CreatedOn desc ";

                }
                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(qry);

                if (dt.Rows.Count > 0)
                {
                    Session["GridViewAuth"] = dt;
                    //lbl_total.Text = dt.Rows.Count.ToString();
                    GridViewAuth.DataSource = dt;
                    GridViewAuth.DataBind();
                }
                else
                {
                    //lbl_total.Text = dt.Rows.Count.ToString();
                    GridViewAuth.DataSource = null;
                    GridViewAuth.DataBind();
                }

        
             

            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }
        }


        protected void GridViewAuth_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewAuth.PageIndex = e.NewPageIndex;
            this.bindgrid();
        }

        protected void GridViewAuth_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(GridViewAuth, "Select$" + e.Row.RowIndex);
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
        protected void GridViewAuth_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                //Reference the GridView Row.
                GridViewRow row = GridViewAuth.Rows[rowIndex];
            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }

        }
        protected void GridViewAuth_SelectedIndexChanged(object sender, EventArgs e)
        {

            try
            {
                Label lblCerpacNo = (Label)GridViewAuth.SelectedRow.FindControl("lblCerpacNo");
                //string qry = "select a.*,b.* from People as a , PeopleChild as b where a.cerpac_no = b.CerpacNo and a.cerpac_file_no=b.FORMNO and (b.IsAuthorized=0 or b.IsAuthorized IS NULL) and b.IsVerified=1 and a.cerpac_no='" + lblCerpacNo.Text.ToString().Trim() + "'";

                string Qty1 = "SELECT Title,people_id ,tile1,forename,middle_name,surname,sex,cerpac_no,cerpac_file_no,cerpac_receipt_date , picture    ,cerpac_expiry_date,registration_area,registration_code,file_no,passport_no,nationality,passport_issue_date,passport_expiry_date " +
                    ",passport_issue_loc,passport_issue_by,date_of_birth,place_of_birth,nigeria_add_1,nigeria_add_2,nigeria_tel_no,abroad_add_1     ,abroad_add_2,abroad_tel_no,company,company_add_1,company_add_2,designation,employment_date,company_tel_no,company_fax_no " +
                    ",email,verid_template,ContactNo,userImage,IsVerified,IsAuthorized,IsProduced,VerifiedBy,AuthorizedBy,ProducedBy     ,ProducedOn,AuthorizedOn,VerifiedOn,IsRejected,RejectedBy,RejectedOn,RejectionReason,ZoneNote,AuthNote,ProdNote,QualNote " +
                    ",IsDependent,DesignationCode,DependentOn,ISARCR,ConfirmedBy,ConfirmedOn,Cerpac_ExpiryDt,Cerpac_IssuedDt,IsQual,QualBy,QualOn,CompanyName    ,date_system_modified  " +
                    " FROM cerpac.dbo.vw_ApplicantDetails where cerpac_no='" + lblCerpacNo.Text.ToString().Trim() + "'";
                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(Qty1);
                string Cerpac = "", FormNo = "";
                if (dt.Rows.Count > 0)
                {
                    /**********Fetch Image**************/


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

                    Cerpac = dt.Rows[0]["cerpac_no"].ToString().Trim();
                    FormNo = dt.Rows[0]["cerpac_file_no"].ToString().Trim();
                    lblCerpacNo1.Text = dt.Rows[0]["cerpac_no"].ToString().Trim();

                    /***********Personal Details************************/
                    lblTitle.Text = dt.Rows[0]["title"].ToString().Trim();
                    lblFristName.Text = dt.Rows[0]["forename"].ToString().Trim();
                    lblLastName.Text = dt.Rows[0]["surname"].ToString().Trim();
                    lblDOB.Text = dt.Rows[0]["date_of_birth"].ToString().Trim();
                    lblSex.Text = dt.Rows[0]["sex"].ToString().Trim();
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
                    Qty = "  Select row_number() over( order by (select null)) [SLNo], T1.App_Id, T1.Form_No, T3.DocName, T4.Doc_Tab_Name, T2.Doc_Number, T1.App_DocImage as Doc_Image, T2.Doc_IssueDate, T2.Doc_ExpiryDate from [dbo].[tbl_eCerpac_Applicant_Document] T1 LEFT OUTER JOIN tbl_eCerpac_ApplicantDocumentDetails T2 on T1.App_id = T2.App_id and T1.Doc_Id = T2.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocumentType] T3 on T1.Doc_id = T3.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocType_Tab] T4 on T3.Doc_Tab = T4.Doc_Tab " +
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
                    Qty = "  Select row_number() over( order by (select null)) [SLNo], T1.App_Id, T1.Form_No, T3.DocName, T4.Doc_Tab_Name, T2.Doc_Number, T1.App_DocImage as Doc_Image, T2.Doc_IssueDate, T2.Doc_ExpiryDate from [dbo].[tbl_eCerpac_Applicant_Document] T1 LEFT OUTER JOIN tbl_eCerpac_ApplicantDocumentDetails T2 on T1.App_id = T2.App_id and T1.Doc_Id = T2.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocumentType] T3 on T1.Doc_id = T3.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocType_Tab] T4 on T3.Doc_Tab = T4.Doc_Tab " +
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
                    Qty = "  Select row_number() over( order by (select null)) [SLNo], T1.App_Id, T1.Form_No, T3.DocName, T4.Doc_Tab_Name, T2.Doc_Number, T1.App_DocImage as Doc_Image, T2.Doc_IssueDate, T2.Doc_ExpiryDate from [dbo].[tbl_eCerpac_Applicant_Document] T1 LEFT OUTER JOIN tbl_eCerpac_ApplicantDocumentDetails T2 on T1.App_id = T2.App_id and T1.Doc_Id = T2.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocumentType] T3 on T1.Doc_id = T3.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocType_Tab] T4 on T3.Doc_Tab = T4.Doc_Tab " +
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
                    Qty = "  Select row_number() over( order by (select null)) [SLNo], T1.App_Id, T1.Form_No, T3.DocName, T4.Doc_Tab_Name, T2.Doc_Number, T1.App_DocImage as Doc_Image, T2.Doc_IssueDate, T2.Doc_ExpiryDate from [dbo].[tbl_eCerpac_Applicant_Document] T1 LEFT OUTER JOIN tbl_eCerpac_ApplicantDocumentDetails T2 on T1.App_id = T2.App_id and T1.Doc_Id = T2.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocumentType] T3 on T1.Doc_id = T3.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocType_Tab] T4 on T3.Doc_Tab = T4.Doc_Tab " +
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
    " from vw_ApplicantDetails A LEFT OUTER JOIN vw_ApplicantDocument B ON A.cerpac_file_no=B.Form_No where isnull(A.IsAuthorized,0)=0  and ( A.cerpac_no like '" + TextAppId.Text.ToString() + "%' or A.cerpac_file_no like '" + TextAppId.Text.ToString() + "%' ) " + 
    " group by  A.CreatedOn, A.cerpac_no, (A.forename+' '+A.surname) , A.cerpac_file_no, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) " +
    " order by A.CreatedOn desc ";

          
                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(qry);

                if (dt.Rows.Count > 0)
                {
                    Session["GridViewAuth"] = dt;
                    //lbl_total.Text = dt.Rows.Count.ToString();
                    GridViewAuth.DataSource = dt;
                    GridViewAuth.DataBind();
                }
                else
                {
                    //lbl_total.Text = dt.Rows.Count.ToString();
                    GridViewAuth.DataSource = null;
                    GridViewAuth.DataBind();
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


        protected void btnBack_Click(object sender, EventArgs e)
        {
            //Server.Transfer("~/frmAuthorizationProcess.aspx", false);
            Response.Redirect(Request.RawUrl);
            
        }






        protected void btnVerify_Click1(object sender, EventArgs e)
        {
            //------------Please check all Green the radio button----------------

           
        
            try
            {
                string Tab1 = "", Tab1DY1 = "", Tab1DY2 = "", Tab1DY = "";

                //-----------Tab 2 ---------------------------

                if (GtxtTitle.Checked == true)
                    ViewState["Title"]  = "1";
                else if (RtxtTitle.Checked == true)
                    ViewState["Title"] = "-1";
                else
                {
                    ViewState["Title"] = "0";
                    Tab1 = Tab1 + "Title ,";
                }

                if (GtxtFirstName.Checked == true)
                    ViewState["FirstName"]   = "1";
                else if (RtxtFirstName.Checked == true)
                    ViewState["FirstName"] = "-1";
                else
                {
                    ViewState["FirstName"] = "0";
                    Tab1 = Tab1 + "FirstName ,";
                }

                if (GtxtLastName.Checked == true)
                    ViewState["LastName"]    = "1";
                else if (RtxtLastName.Checked == true)
                    ViewState["LastName"] = "-1";
                else
                {
                    ViewState["LastName"] = "0";
                    Tab1 = Tab1 + "LastName ,";
                }


                if (GtxtDOB.Checked == true)
                    ViewState["DOB"]   = "1";
                else if (RtxtDOB.Checked == true)
                    ViewState["DOB"] = "-1";
                else
                {
                    ViewState["DOB"] = "0";
                    Tab1 = Tab1 + "DOB ,";
                }


                if (GtxtEmailID.Checked == true)
                    ViewState["EmailID"]   = "1";
                else if (RtxtEmailID.Checked == true)
                    ViewState["EmailID"] = "-1";
                else
                {
                    ViewState["EmailID"] = "0";
                    Tab1 = Tab1 + "EmailID ,";
                }

                if (GtxtSex.Checked == true)
                    ViewState["Sex"]   = "1";
                else if (RtxtSex.Checked == true)
                    ViewState["Sex"] = "-1";
                else 
                {
                    ViewState["Sex"] = "0";
                    Tab1 = Tab1 + "Sex ,";
                }


                if (GtxtNationality.Checked == true)
                    ViewState["Nationality"]  = "1";
                else if (RtxtNationality.Checked == true)
                    ViewState["Nationality"] = "-1";
                else
                {
                    ViewState["Nationality"] = "0";
                    Tab1 = Tab1 + "Nationality ,";
                }

                if (GtxtPOB.Checked == true)
                    ViewState["POB"]  = "1";
                else if (RtxtPOB.Checked == true)
                    ViewState["POB"] = "-1";
                else
                {
                    ViewState["POB"] = "0";
                    Tab1 = Tab1 + "Place of Birth ,";
                }

                if (GtxtContactNo.Checked == true)
                    ViewState["ContactNo"]   = "1";
                else if (RtxtContactNo.Checked == true)
                    ViewState["ContactNo"] = "-1";
                else
                {
                    ViewState["ContactNo"] = "0";
                    Tab1 = Tab1 + "Contact No ,";
                }
           

                if (GtxtAddress1.Checked == true)
                    ViewState["Address1"]    = "1";
                else if (RtxtAddress1.Checked == true)
                    ViewState["Address1"] = "-1";
                else 
                {
                    ViewState["Address1"] = "0";
                    Tab1 = Tab1 + "Address 1 ,";
                }

                if (GtxtAddress2.Checked == true)
                    ViewState["Address2"]   = "1";
                else if (RtxtAddress2.Checked == true)
                    ViewState["Address2"] = "-1";
                else 
                {
                    ViewState["Address2"] = "0";
                    Tab1 = Tab1 + "Address 2 ,";
                }

         
                int i = 2;
                foreach (GridViewRow r in gdPImage.Rows)
                {

                    string chk = Request.Form["ctl00$ContentPlaceHolder1$gdPImage$ctl" + i.ToString("00") + "$PN"];

                    //ctl00$ContentPlaceHolder1$gdAImage$ctl02$LN
                    if (chk == "1")
                    {
                        Label lblDocName = (Label)r.FindControl("lblDocName");
                        Tab1DY1 = Tab1DY1 + lblDocName.Text.ToString() + " , ";
                    }

                    else if (chk == "-1")
                    {

                        Label lblDocName = (Label)r.FindControl("lblDocName");
                        Tab1DY2 = Tab1DY2 + lblDocName.Text.ToString() + " , ";
                    }
                    else
                    {
                        Label lblDocName = (Label)r.FindControl("lblDocName");
                        Tab1DY = Tab1DY + lblDocName.Text.ToString() + " , ";
                    }

                    i = i + 1;
                }

                ViewState["Tab1"] = Tab1;
                ViewState["GTab1"] = Tab1DY1;
                ViewState["RTab1"] = Tab1DY2;

                //-----------Tab 2 ---------------------------
                string Tab2="", Tab2DY1 = "", Tab2DY2 = "", Tab2DY = "";
             
                if (GtxtPassportNo.Checked == true)
                    ViewState["PassportNo"]  = "1";
                else if (RtxtPassportNo.Checked == true)
                    ViewState["PassportNo"] = "-1";
                else
                {
                    ViewState["PassportNo"] = "0";
                    Tab2 = Tab2 + "Passport No. ,";
                }


                if (GtxtPlaceOfIssue.Checked == true)
                    ViewState["PlaceOfIssue"]   = "1";
                else if (RtxtPlaceOfIssue.Checked == true)
                    ViewState["PlaceOfIssue"] = "-1";
                else
                {
                    ViewState["PlaceOfIssue"] = "0";
                    Tab2 = Tab2 + "Place Of Issue ,";
                }


                if (GtxtPassportIssuedBy.Checked == true)
                    ViewState["PassportIssuedBy"]    = "1";
                else if (RtxtPassportIssuedBy.Checked == true)
                    ViewState["PassportIssuedBy"] = "-1";
                else
                {
                    ViewState["PassportIssuedBy"] = "0";
                    Tab2 = Tab2 + "Passport Issued By ,";
                }


                if (GtxtPassportIssueDate.Checked == true)
                    ViewState["PassportIssueDate"]    = "1";
                else if (RtxtPassportIssueDate.Checked == true)
                    ViewState["PassportIssueDate"] = "-1";
                else
                {
                    ViewState["PassportIssueDate"] = "0";
                    Tab2 = Tab2 + "Passport Issue Date ,";
                }


                if (GtxtPassportExpiryDate.Checked == true)
                    ViewState["PassportExpiryDate"]       = "1";
                else if (RtxtPassportExpiryDate.Checked == true)
                    ViewState["PassportExpiryDate"] = "-1";
                else
                {
                    ViewState["PassportExpiryDate"] = "0";
                    Tab2 = Tab2 + "Passport Expiry Date ,";
                }

                int j = 2;
                foreach (GridViewRow r in gdAImage.Rows)
                {
                   
                        string chk = Request.Form["ctl00$ContentPlaceHolder1$gdAImage$ctl" + j.ToString("00") + "$LN"];

                        if (chk == "1")
                        {
                            Label lblDocName = (Label)r.FindControl("lblDocName");
                            Tab2DY1 = Tab2DY1 + lblDocName.Text.ToString() +" , ";
                        }
                       
                        else if (chk == "-1")
                        {

                            Label lblDocName = (Label)r.FindControl("lblDocName");
                            Tab2DY2 = Tab2DY2 + lblDocName.Text.ToString() +" , ";
                        }
                        else
                        {
                            Label lblDocName = (Label)r.FindControl("lblDocName");
                            Tab2DY = Tab2DY + lblDocName.Text.ToString() +" , ";
                        }
                    
                    j = j + 1;
                }

                ViewState["Tab2"] = Tab2;
                ViewState["GTab2"] = Tab2DY1;
                ViewState["RTab2"] = Tab2DY2;
                //-----------Tab 3 ---------------------------
                string Tab3 = "", Tab3DY1 = "", Tab3DY2 = "", Tab3DY = "";
               
                

                if (GtxtCompanyRC.Checked == true)
                    ViewState["CompanyRC"]  = "1";
                else if (RtxtCompanyRC.Checked == true)
                    ViewState["CompanyRC"] = "-1";
                else
                {
                    ViewState["CompanyRC"] = "0";
                    Tab3 = Tab3 + "Company RC ,";
                }

                if (GtxtCompanyName.Checked == true)
                    ViewState["CompanyName"]    = "1";
                else if (RtxtCompanyName.Checked == true)
                    ViewState["CompanyName"] = "-1";
                else
                {
                    ViewState["CompanyName"] = "0";
                    Tab3 = Tab3 + "Company Name ,";
                }


                if (GtxtComAddress1.Checked == true)
                    ViewState["ComAddress1"]    = "1";
                else if (RtxtComAddress1.Checked == true)
                    ViewState["ComAddress1"] = "-1";
                else
                {
                    ViewState["ComAddress1"] = "0";
                    Tab3 = Tab3 + "Company Address 1 ,";
                }


                if (GtxtComAddress2.Checked == true)
                    ViewState["ComAddress2"]   = "1";
                else if (RtxtComAddress2.Checked == true)
                    ViewState["ComAddress2"] = "-1";
                else
                {
                    ViewState["ComAddress2"] = "0";
                    Tab3 = Tab3 + "Company Address 2 ,";
                }


                if (GtxtDesignation.Checked == true)
                    ViewState["Designation"]  = "1";
                else if (RtxtDesignation.Checked == true)
                    ViewState["Designation"] = "-1";
                else
                {
                    ViewState["Designation"] = "0";
                    Tab3 = Tab3 + "Designation ,";
                }


                if (GtxtComTelephone.Checked == true)
                    ViewState["ComTelephone"]  = "1";
                else if (RtxtComTelephone.Checked == true)
                    ViewState["ComTelephone"] = "-1";
                else
                {
                    ViewState["ComTelephone"] = "0";
                    Tab3 = Tab3 + "Company Telephone No ,";
                }


                if (GtxtComFaxNo.Checked == true)
                    ViewState["ComFaxNo"]  = "1";
                else if (RtxtComFaxNo.Checked == true)
                    ViewState["ComFaxNo"] = "-1";
                else
                {
                    ViewState["ComFaxNo"] = "0";
                    Tab3 = Tab3 + "Company Fax No. ,";
                }


                if (GtxtEmploymentDt.Checked == true)
                    ViewState["EmploymentDt"]   = "1";
                else if (RtxtEmploymentDt.Checked == true)
                    ViewState["EmploymentDt"] = "-1";
                else
                {
                    ViewState["EmploymentDt"] = "0";
                    Tab3 = Tab3 + "Employment Date,";
                }


                int k = 2;
                foreach (GridViewRow r in gdQrgImage.Rows)
                {

                    string chk = Request.Form["ctl00$ContentPlaceHolder1$gdQrgImage$ctl" + k.ToString("00") + "$QN"];

                    if (chk == "1")
                    {
                        Label lblDocName = (Label)r.FindControl("lblDocName");
                        Tab3DY1 = Tab3DY1 + lblDocName.Text.ToString() + " , ";
                    }

                    else if (chk == "-1")
                    {

                        Label lblDocName = (Label)r.FindControl("lblDocName");
                        Tab3DY2 = Tab3DY2 + lblDocName.Text.ToString() + " , ";
                    }
                    else
                    {
                        Label lblDocName = (Label)r.FindControl("lblDocName");
                        Tab3DY = Tab3DY + lblDocName.Text.ToString() + " , ";
                    }

                    k = k + 1;
                }

                ViewState["Tab3"] = Tab3;
                ViewState["GTab3"] = Tab3DY1;
                ViewState["RTab3"] = Tab3DY2;

                //-----------Tab 4 ---------------------------
                string Tab4 = "", Tab4DY1 = "", Tab4DY2 = "", Tab4DY = "";
                   


                if (GtxtDegree.Checked == true)
                    ViewState["Degree"]  = "1";
                else if (RtxtDegree.Checked == true)
                    ViewState["Degree"] = "-1";
                else
                {
                    ViewState["Degree"] = "0";
                    Tab4 = Tab4 + "Degree , ";
                }


                if (GtxtInstitutionName.Checked == true)
                    ViewState["InstitutionName"]   = "1";
                else if (RtxtInstitutionName.Checked == true)
                    ViewState["InstitutionName"] = "-1";
                else
                {
                    ViewState["InstitutionName"] = "0";
                    Tab4 = Tab4 + "Institution Name ,";
                }


                if (GtxtYearGraduation.Checked == true)
                    ViewState["YearGraduation"]   = "1";
                else if (RtxtYearGraduation.Checked == true)
                    ViewState["YearGraduation"] = "-1";
                else
                {
                    ViewState["YearGraduation"] = "0";
                    Tab4 = Tab4 + "Graduation Year ";
                }

                int l = 2;
                foreach (GridViewRow r in gdEImage.Rows)
                {

                    string chk = Request.Form["ctl00$ContentPlaceHolder1$gdEImage$ctl" + l.ToString("00") + "$EN"];

                    if (chk == "1")
                    {
                        Label lblDocName = (Label)r.FindControl("lblDocName");
                        Tab4DY1 = Tab4DY1 + lblDocName.Text.ToString() + " , ";
                    }

                    else if (chk == "-1")
                    {

                        Label lblDocName = (Label)r.FindControl("lblDocName");
                        Tab4DY2 = Tab4DY2 + lblDocName.Text.ToString() + " , ";
                    }
                    else
                    {
                        Label lblDocName = (Label)r.FindControl("lblDocName");
                        Tab4DY = Tab4DY + lblDocName.Text.ToString() + " , ";
                    }

                    l = l + 1;
                }

                ViewState["Tab4"] = Tab4;
                ViewState["GTab4"] = Tab4DY1;
                ViewState["RTab4"] = Tab4DY2;

                if (Tab1 != "" || Tab2 != "" || Tab3 != "" || Tab4 != "")
                {
                    pnlMain.Attributes.Add("style", "display:none;"); ;
                    pnldisplay.Attributes.Add("style", "display:none;");
                    pnlunCheckData.Attributes.Add("style", "display:block;");
                    pnlmsg.Attributes.Add("style", "display:none;");
                    pnlVConfirm.Attributes.Add("style", "display:none;");
                    lblCheckStatus.Text = "Data feilds Need to validate  : <br />" + Tab1 + Tab2 + Tab3 + Tab4;
                }
                if (Tab1DY != "" || Tab2DY != "" || Tab3DY != "" || Tab4DY != "")
                {
                    pnlMain.Attributes.Add("style", "display:none;"); ;
                    pnldisplay.Attributes.Add("style", "display:none;");
                    pnlunCheckData.Attributes.Add("style", "display:block;");
                    pnlmsg.Attributes.Add("style", "display:none;");
                    pnlVConfirm.Attributes.Add("style", "display:none;");
                    lblCheckDoc.Text = "Document Need to validate  : <br />" + Tab1DY + Tab2DY + Tab3DY + Tab4DY;
                }
                else
                {
                    pnlMain.Attributes.Add("style", "display:none;"); ;
                    pnldisplay.Attributes.Add("style", "display:none;");
                    pnlunCheckData.Attributes.Add("style", "display:none;");
                    pnlmsg.Attributes.Add("style", "display:none;");
                    pnlVConfirm.Attributes.Add("style", "display:block;");
                }



            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }
        }



        protected void btnVNo_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }

        protected void btnVYes_Click(object sender, EventArgs e)
        {

            try
            {


                String Tab1 = ViewState["Tab1"].ToString();
                String GTab1 = ViewState["GTab1"].ToString();
                String RTab1 = ViewState["RTab1"].ToString();

                String Tab2 = ViewState["Tab2"].ToString();
                String GTab2 = ViewState["GTab2"].ToString();
                String RTab2 = ViewState["RTab2"].ToString();

                String Tab3 = ViewState["Tab3"].ToString();
                String GTab3 = ViewState["GTab3"].ToString();
                String RTab3 = ViewState["RTab3"].ToString();

                String Tab4 = ViewState["Tab4"].ToString();
                String GTab4 = ViewState["GTab4"].ToString();
                String RTab4 = ViewState["RTab4"].ToString();

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "USP_CERPAC_DATA_NIS01";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@Title", ViewState["Title"].ToString());
                cmd.Parameters.AddWithValue("@FirstName", ViewState["FirstName"].ToString());
                cmd.Parameters.AddWithValue("@LastName", ViewState["LastName"].ToString());
                cmd.Parameters.AddWithValue("@DOB", ViewState["DOB"].ToString());
                cmd.Parameters.AddWithValue("@EmailID", ViewState["EmailID"].ToString());
                cmd.Parameters.AddWithValue("@Sex", ViewState["Sex"].ToString());
                cmd.Parameters.AddWithValue("@Nationality", ViewState["Nationality"].ToString());             
                cmd.Parameters.AddWithValue("@POB", ViewState["POB"].ToString());
                cmd.Parameters.AddWithValue("@ContactNo", ViewState["ContactNo"].ToString());
                cmd.Parameters.AddWithValue("@Address1", ViewState["Address1"].ToString());
                cmd.Parameters.AddWithValue("@Address2", ViewState["Address2"].ToString());
                cmd.Parameters.AddWithValue("@GTab1", ViewState["GTab1"].ToString());
                cmd.Parameters.AddWithValue("@RTab1", ViewState["RTab1"].ToString());

                cmd.Parameters.AddWithValue("@PassportNo", ViewState["PassportNo"].ToString());
                cmd.Parameters.AddWithValue("@PlaceOfIssue", ViewState["PlaceOfIssue"].ToString());
                cmd.Parameters.AddWithValue("@PassportIssuedBy", ViewState["PassportIssuedBy"].ToString());
                cmd.Parameters.AddWithValue("@PassportIssueDate", ViewState["PassportIssueDate"].ToString());
                cmd.Parameters.AddWithValue("@PassportExpiryDate", ViewState["PassportExpiryDate"].ToString());
                cmd.Parameters.AddWithValue("@GTab2", ViewState["GTab2"].ToString());
                cmd.Parameters.AddWithValue("@RTab2", ViewState["RTab2"].ToString());
              
                cmd.Parameters.AddWithValue("@CompanyRC", ViewState["CompanyRC"].ToString());
                cmd.Parameters.AddWithValue("@CompanyName", ViewState["CompanyName"].ToString());
                cmd.Parameters.AddWithValue("@ComAddress1", ViewState["ComAddress1"].ToString());
                cmd.Parameters.AddWithValue("@ComAddress2", ViewState["ComAddress2"].ToString());
                cmd.Parameters.AddWithValue("@Designation", ViewState["Designation"].ToString());
                cmd.Parameters.AddWithValue("@ComTelephone", ViewState["ComTelephone"].ToString());
                cmd.Parameters.AddWithValue("@ComFaxNo", ViewState["ComFaxNo"].ToString());
                cmd.Parameters.AddWithValue("@EmploymentDt", ViewState["EmploymentDt"].ToString());
                cmd.Parameters.AddWithValue("@GTab3", ViewState["GTab3"].ToString());
                cmd.Parameters.AddWithValue("@RTab3", ViewState["RTab3"].ToString());

               

                cmd.Parameters.AddWithValue("@Degree", ViewState["Degree"].ToString());
                cmd.Parameters.AddWithValue("@InstitutionName", ViewState["InstitutionName"].ToString());
                cmd.Parameters.AddWithValue("@YearGraduation", ViewState["YearGraduation"].ToString());
                cmd.Parameters.AddWithValue("@GTab4", ViewState["GTab4"].ToString());
                cmd.Parameters.AddWithValue("@RTab4", ViewState["RTab4"].ToString());

                cmd.Parameters.AddWithValue("@UserId", dt_login_details.Rows[0]["Userid"].ToString());
                cmd.Parameters.AddWithValue("@cerpacno", lblCerpacNo1.Text.ToString().Trim());
                cmd.Parameters.AddWithValue("@App_Id", lblCerpacNo1.Text.ToString().Trim());
                cmd.Parameters.AddWithValue("@Form_No", lblCerpacNo1.Text.ToString().Trim());
           


                cmd.Parameters.AddWithValue("@authnotes", "Remark");
                SqlParameter output = new SqlParameter("@SuccessId", SqlDbType.Int);
                output.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(output);
                con.Open();
                cmd.ExecuteNonQuery();
                String R = output.Value.ToString();
                con.Close();


                if (R != String.Empty)
                {
                    pnlMain.Attributes.Add("style", "display:none;"); ;
                    pnldisplay.Attributes.Add("style", "display:none;");
                    pnlmsg.Attributes.Add("style", "display:block;");
                    pnlVConfirm.Attributes.Add("style", "display:none;");
                }
                else
                {
                    lblloginmsg.Attributes.Add("class", "active");
                    lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                    lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Company details are not found !" + " </h4>";
                }
            }
            catch (Exception ex)
            {
                throw (ex);
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

                GridViewAuth.SelectedIndex = -1;
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
                Position(GridViewAuth, sortOrder, currentSortColumn);
            else
                Position(GridViewAuth, sortOrder, currentSortColumn);
        }

        private void Position(GridView gridView, App_Code.SortOrder currentSortOrder, string currentSortColumn)
        {
            if ((gridView.Rows.Count == 0) || (string.IsNullOrEmpty(currentSortColumn)))
                return;

            Image glyph = new Image();
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

        protected void btnBackUnCheckData_Click(object sender, EventArgs e)
        {
            pnlMain.Attributes.Add("style", "display:none;"); ;
            pnldisplay.Attributes.Add("style", "display:block;");
            pnlunCheckData.Attributes.Add("style", "display:none;");
            pnlmsg.Attributes.Add("style", "display:none;");
            pnlVConfirm.Attributes.Add("style", "display:none;");
        }
    }
}