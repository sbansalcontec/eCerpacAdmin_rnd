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
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;



namespace eCerpac_NIS
{
    public partial class frmAuthorizationProcess : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(CommonFunctions.connection.ToString());
        DataTable dt_login_details = new DataTable();

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
                    Server.Transfer("Login.aspx", false);
                }

                dt_login_details = (DataTable)Session["LoginDetails"];

                if (!IsPostBack)
                {
                    bindgrid();

                    pnlMain.Attributes.Add("style", "display:block;"); ;
                    pnldisplay.Attributes.Add("style", "display:none;");
                    pnlmsg.Attributes.Add("style", "display:none;");
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
                    qry = " Select  A.cerpac_no, (A.forename+' '+A.surname)as Name, A.cerpac_file_no as FORMNO, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) as Status ,  convert(varchar(10), A.CreatedOn,103) as CreatedOn,Authorizedby   " +
                       " from vw_ApplicantDetails A LEFT OUTER JOIN vw_ApplicantDocument B ON A.cerpac_file_no=B.Form_No where isnull(A.IsAuthorized,0)=0   group by  A.CreatedOn, A.cerpac_no, (A.forename+' '+A.surname) , A.cerpac_file_no, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End),AuthorizedBy " +
                       " order by " + Condition + "  ";
                }
                else
                {
                    qry = " Select  A.cerpac_no, (A.forename+' '+A.surname)as Name, A.cerpac_file_no as FORMNO, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) as Status ,  convert(varchar(10), A.CreatedOn,103) as CreatedOn,AuthorizedBy   " +
                     " from vw_ApplicantDetails A LEFT OUTER JOIN vw_ApplicantDocument B ON A.cerpac_file_no=B.Form_No where isnull(A.IsAuthorized,0)=0   group by  A.CreatedOn, A.cerpac_no, (A.forename+' '+A.surname) , A.cerpac_file_no, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End),AuthorizedBy " +
                    " order by   A.CreatedOn desc ";

                }

                //and (AuthorizedBy is null or Authorizedby='"+ dt_login_details.Rows[0]["Userid"].ToString() + "')

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
                    DataRowView rowView = (DataRowView)e.Row.DataItem;

                    int serialNo = e.Row.RowIndex + 1; // Generate serial number (1-based index)
                    Label lblSerialNo = (Label)e.Row.FindControl("lblSerialNo");
                    if (lblSerialNo != null)
                    {
                        lblSerialNo.Text = serialNo.ToString();
                    }
                    // Retrieve values using column names or indices
                    string columnNameValue = rowView["Authorizedby"].ToString();

                    if(columnNameValue== dt_login_details.Rows[0]["Userid"].ToString() || columnNameValue=="")
                    {
                        e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(GridViewAuth, "Select$" + e.Row.RowIndex);
                        e.Row.Attributes["style"] = "cursor:pointer";
                    }
                    else
                    {
                        e.Row.ToolTip = "Already assigned to another one";
                        e.Row.BackColor = System.Drawing.Color.LightCoral;
                        ImageButton imgBtnAssign = (ImageButton)e.Row.FindControl("imgBtnAssign");
                        imgBtnAssign.Enabled = false;
                        imgBtnAssign.ImageUrl = "~/eImage_files/Task_assigned.jpg";
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
        protected void GridViewAuth_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {

                //if (e.CommandName == "Assign")
                //{
                // int userID = Convert.ToInt32(e.CommandArgument);
                //}
                // int rowIndex = Convert.ToInt32(e.CommandArgument);

                //Reference the GridView Row. //
                // GridViewRow row = GridViewAuth.Rows[rowIndex];
                //string cerpacNo = e.CommandArgument.ToString(); // Get CerpacNo directly
                //bindgrid_assign(cerpacNo); // Pass to function
                if (e.CommandName == "Assign")
                {
                    string cerpacNo = e.CommandArgument.ToString(); // Get CerpacNo directly
                    bindgrid_assign(cerpacNo);
                }
                else
                {
                    int rowIndex = Convert.ToInt32(e.CommandArgument);

                    //Reference the GridView Row.
                    GridViewRow row = GridViewAuth.Rows[rowIndex];

                    //string cerpacNo = e.CommandArgument.ToString();
                    Label lblCerpacNo = (Label)row.Cells[2].FindControl("lblCerpacNo");// Get CerpacNo directly
                    bindgrid_assign(lblCerpacNo.Text); // Pass to function}

                }
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

                string Qty1 = "SELECT Title,people_id , Category_Type , tile1,forename,middle_name,surname,sex,cerpac_no,cerpac_file_no,cerpac_receipt_date , picture    ,cerpac_expiry_date,registration_area,registration_code,file_no,passport_no,nationality,passport_issue_date,passport_expiry_date,PaymentMode1 " +
                    ",passport_issue_loc,passport_issue_by,date_of_birth,place_of_birth,nigeria_add_1,nigeria_add_2,nigeria_tel_no,abroad_add_1     ,abroad_add_2,abroad_tel_no,company,company_add_1,company_add_2,designation,employment_date,company_tel_no,company_fax_no " +
                    ",email,verid_template,ContactNo,userImage,IsVerified,IsAuthorized,IsProduced,VerifiedBy,AuthorizedBy,ProducedBy     ,ProducedOn,AuthorizedOn,VerifiedOn,IsRejected,RejectedBy,RejectedOn,RejectionReason,ZoneNote,AuthNote,ProdNote,QualNote " + ",IsDependent,DesignationCode,DependentOn,ISARCR,ConfirmedBy,ConfirmedOn,Cerpac_ExpiryDt,Cerpac_IssuedDt,IsQual,QualBy,QualOn,CompanyName    , convert(varchar(10), date_system_modified ,103) as date_system_modified, AppType,MaritalStatus " +
                    " FROM vw_ApplicantDetails where cerpac_no='" + lblCerpacNo.Text.ToString().Trim() + "'";
                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(Qty1);
                string Cerpac = "", FormNo = "";
                if (dt.Rows.Count > 0)
                {
                    if(dt.Rows[0]["AuthorizedBy"].ToString().Trim() != "" && dt.Rows[0]["AuthorizedBy"].ToString().Trim()!= dt_login_details.Rows[0]["Userid"].ToString())
                    {
                        lblloginmsg.Attributes.Add("class", "active");
                        lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                        lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Already assigned to another one !" + " </h4>";
                        return;
                    }

                    string updateQuery = "UPDATE peoplechild " +
                                     "SET AuthorizedBy = @VerifiedBy, AuthorizedOn = GETDATE() " +
                                     "WHERE FormNo = @FormNo";

                    using (SqlCommand updateCmd = new SqlCommand(updateQuery, con))
                    {
                        con.Open();
                        updateCmd.Parameters.AddWithValue("@VerifiedBy", dt_login_details.Rows[0]["Userid"].ToString());
                        updateCmd.Parameters.AddWithValue("@FormNo", lblCerpacNo.Text.ToString().Trim());
                        int rowsAffected = updateCmd.ExecuteNonQuery();
                        con.Close();
                    }
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
                    ViewState["Cerpac"] = Cerpac;
                   

                    FormNo = dt.Rows[0]["cerpac_file_no"].ToString().Trim();
                    ViewState["FormNo"] = FormNo;
                    // lblCategory.Text = FormNo.Substring(0, 2);
                    lblCategory.Text = dt.Rows[0]["Category_Type"].ToString().Trim();
                    lblCIssueDate.Text = dt.Rows[0]["cerpac_receipt_date"].ToString().Trim();
                    lblCExpiryDate.Text = dt.Rows[0]["cerpac_expiry_date"].ToString().Trim();

                    lblCerpacNo1.Text = dt.Rows[0]["cerpac_no"].ToString().Trim();
                    lblPaymentMode.Text = dt.Rows[0]["PaymentMode1"].ToString().Trim();
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
                    Qty = "  Select row_number() over( order by (select null)) [SLNo], T1.App_Id, T1.Form_No, T3.DocName, T4.Doc_Tab_Name, T2.Doc_Number, T1.App_DocImage as Doc_Image, T2.Doc_IssueDate, T2.Doc_ExpiryDate from   [dbo].[tbl_eCerpac_Applicant_Document] T1 LEFT OUTER JOIN tbl_eCerpac_ApplicantDocumentDetails T2 on T1.App_id = T2.App_id and T1.Doc_Id = T2.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocumentType] T3 on T1.Doc_id = T3.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocType_Tab] T4 on T3.Doc_Tab = T4.Doc_Tab " +
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
                string allComments = "select App_id,PassportNo,Level, UserName, Comments,CONVERT(VARCHAR, a.CreatedOn, 103) as date from tbl_eCerpac_NIS_CommentDetails a, UserMaster b where a.UserID=b.UserID and Form_No='" + FormNo + "'";

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
                else
                {
                    tbl_comments.Visible = false;
                }
            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }
        }


        public void bindgrid_assign(string lblCerpacNo)
        {
            try
            {
               // Label lblCerpacNo = (Label)GridViewAuth.SelectedRow.FindControl("lblCerpacNo");
                //string qry = "select a.*,b.* from People as a , PeopleChild as b where a.cerpac_no = b.CerpacNo and a.cerpac_file_no=b.FORMNO and (b.IsAuthorized=0 or b.IsAuthorized IS NULL) and b.IsVerified=1 and a.cerpac_no='" + lblCerpacNo.Text.ToString().Trim() + "'";

                string Qty1 = "SELECT Title,people_id , Category_Type , tile1,forename,middle_name,surname,sex,cerpac_no,cerpac_file_no,cerpac_receipt_date , picture    ,cerpac_expiry_date,registration_area,registration_code,file_no,passport_no,nationality,passport_issue_date,passport_expiry_date,PaymentMode1 " +
                    ",passport_issue_loc,passport_issue_by,date_of_birth,place_of_birth,nigeria_add_1,nigeria_add_2,nigeria_tel_no,abroad_add_1     ,abroad_add_2,abroad_tel_no,company,company_add_1,company_add_2,designation,employment_date,company_tel_no,company_fax_no " +
                    ",email,verid_template,ContactNo,userImage,IsVerified,IsAuthorized,IsProduced,VerifiedBy,AuthorizedBy,ProducedBy     ,ProducedOn,AuthorizedOn,VerifiedOn,IsRejected,RejectedBy,RejectedOn,RejectionReason,ZoneNote,AuthNote,ProdNote,QualNote " + ",IsDependent,DesignationCode,DependentOn,ISARCR,ConfirmedBy,ConfirmedOn,Cerpac_ExpiryDt,Cerpac_IssuedDt,IsQual,QualBy,QualOn,CompanyName    , convert(varchar(10), date_system_modified ,103) as date_system_modified, AppType,MaritalStatus " +
                    " FROM vw_ApplicantDetails where cerpac_no='" + lblCerpacNo.Trim() + "'";
                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(Qty1);
                string Cerpac = "", FormNo = "";
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["AuthorizedBy"].ToString().Trim() != "" && dt.Rows[0]["AuthorizedBy"].ToString().Trim() != dt_login_details.Rows[0]["Userid"].ToString())
                    {
                        lblloginmsg.Attributes.Add("class", "active");
                        lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                        lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Already assigned to another one !" + " </h4>";
                        return;
                    }

                    string updateQuery = "UPDATE peoplechild " +
                                     "SET AuthorizedBy = @VerifiedBy, AuthorizedOn = GETDATE() " +
                                     "WHERE FormNo = @FormNo";

                    using (SqlCommand updateCmd = new SqlCommand(updateQuery, con))
                    {
                        con.Open();
                        updateCmd.Parameters.AddWithValue("@VerifiedBy", dt_login_details.Rows[0]["Userid"].ToString());
                        updateCmd.Parameters.AddWithValue("@FormNo", lblCerpacNo.ToString().Trim());
                        int rowsAffected = updateCmd.ExecuteNonQuery();
                        con.Close();
                    }
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
                    ViewState["Cerpac"] = Cerpac;


                    FormNo = dt.Rows[0]["cerpac_file_no"].ToString().Trim();
                    ViewState["FormNo"] = FormNo;
                    // lblCategory.Text = FormNo.Substring(0, 2);
                    lblCategory.Text = dt.Rows[0]["Category_Type"].ToString().Trim();
                    lblCIssueDate.Text = dt.Rows[0]["cerpac_receipt_date"].ToString().Trim();
                    lblCExpiryDate.Text = dt.Rows[0]["cerpac_expiry_date"].ToString().Trim();

                    lblCerpacNo1.Text = dt.Rows[0]["cerpac_no"].ToString().Trim();
                    lblPaymentMode.Text = dt.Rows[0]["PaymentMode1"].ToString().Trim();
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
                    Qty = "  Select row_number() over( order by (select null)) [SLNo], T1.App_Id, T1.Form_No, T3.DocName, T4.Doc_Tab_Name, T2.Doc_Number, T1.App_DocImage as Doc_Image, T2.Doc_IssueDate, T2.Doc_ExpiryDate from   [dbo].[tbl_eCerpac_Applicant_Document] T1 LEFT OUTER JOIN tbl_eCerpac_ApplicantDocumentDetails T2 on T1.App_id = T2.App_id and T1.Doc_Id = T2.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocumentType] T3 on T1.Doc_id = T3.Doc_Id LEFT OUTER JOIN [dbo].[tbl_eCerpac_mst_DocType_Tab] T4 on T3.Doc_Tab = T4.Doc_Tab " +
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
                string allComments = "select App_id,PassportNo,Level, UserName, Comments,CONVERT(VARCHAR, a.CreatedOn, 103) as date from tbl_eCerpac_NIS_CommentDetails a, UserMaster b where a.UserID=b.UserID and Form_No='" + FormNo + "'";

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
                else
                {
                    tbl_comments.Visible = false;
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

                string qry = " Select  A.cerpac_no, (A.forename+' '+A.surname)as Name, A.cerpac_file_no as FORMNO, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) as Status, convert(varchar(10), A.CreatedOn,103) as CreatedOn    " +
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

            pnlMain.Attributes.Add("style", "display:block;"); ;
            pnldisplay.Attributes.Add("style", "display:none;");
            pnlmsg.Attributes.Add("style", "display:none;");
        }

      


        protected void btnVerify_Click1(object sender, EventArgs e)
        {
          
            //--------------tab 1 document ------------------------
            string Tab1DY1 = "", Tab1DY2 = "", Tab1DY="";
            int i = 2;
            foreach (GridViewRow r in gdPImage.Rows)
            {

                string chk = Request.Form["ctl00$ContentPlaceHolder1$gdPImage$ctl" + i.ToString("00") + "$PN"];

                //ctl00$ContentPlaceHolder1$gdAImage$ctl02$LN
                if (chk == "1")
                {
                    Label lblDocName = (Label)r.FindControl("lblDocName");
                    Tab1DY1 = Tab1DY1 + lblDocName.Text.ToString() + ",";
                }

                else if (chk == "-1")
                {

                    Label lblDocName = (Label)r.FindControl("lblDocName");
                    Tab1DY2 = Tab1DY2 + lblDocName.Text.ToString() + ","; ;
                }
                else
                {
                    Label lblDocName = (Label)r.FindControl("lblDocName");
                    Tab1DY = Tab1DY + lblDocName.Text.ToString() + " , ";
                }

                i = i + 1;
            }

            ViewState["Tab1DY"] = Tab1DY;
            ViewState["GTab1"] =  Tab1DY1.ToString().Trim() ;
            ViewState["RTab1"] =  Tab1DY2.ToString().Trim() ;


            //--------------tab 1 document ------------------------
            string  Tab2DY1 = "", Tab2DY2 = "", Tab2DY = "";

            int j = 2;
            foreach (GridViewRow r in gdAImage.Rows)
            {

                string chk = Request.Form["ctl00$ContentPlaceHolder1$gdAImage$ctl" + j.ToString("00") + "$LN"];

                if (chk == "1")
                {
                    Label lblDocName = (Label)r.FindControl("lblDocName");
                    Tab2DY1 = Tab2DY1 + lblDocName.Text.ToString() + ",";
                }

                else if (chk == "-1")
                {

                    Label lblDocName = (Label)r.FindControl("lblDocName");
                    Tab2DY2 = Tab2DY2 + lblDocName.Text.ToString() + ",";
                }
                else
                {
                    Label lblDocName = (Label)r.FindControl("lblDocName");
                    Tab2DY = Tab2DY + lblDocName.Text.ToString() + " , ";
                }

                j = j + 1;
            }

            ViewState["Tab2DY"] = Tab2DY;
            ViewState["GTab2"] = Tab2DY1.ToString().Trim() ;
            ViewState["RTab2"] = Tab2DY2.ToString().Trim() ;

            //--------------tab 1 document ------------------------
            string Tab3DY1 = "", Tab3DY2 = "", Tab3DY = "";

            int k = 2;
            foreach (GridViewRow r in gdQrgImage.Rows)
            {

                string chk = Request.Form["ctl00$ContentPlaceHolder1$gdQrgImage$ctl" + k.ToString("00") + "$QN"];

                if (chk == "1")
                {
                    Label lblDocName = (Label)r.FindControl("lblDocName");
                    Tab3DY1 = Tab3DY1 + lblDocName.Text.ToString() + ",";
                }

                else if (chk == "-1")
                {

                    Label lblDocName = (Label)r.FindControl("lblDocName");
                    Tab3DY2 = Tab3DY2 + lblDocName.Text.ToString() + ",";
                }
                else
                {
                    Label lblDocName = (Label)r.FindControl("lblDocName");
                    Tab3DY = Tab3DY + lblDocName.Text.ToString() + " , ";
                }

                k = k + 1;
            }

            ViewState["Tab3DY"] = Tab3DY;
            ViewState["GTab3"] =  Tab3DY1.ToString().Trim() ;
            ViewState["RTab3"] =  Tab3DY2.ToString().Trim() ;

            //--------------tab 1 document ------------------------
            string Tab4DY = "", Tab4DY1 = "", Tab4DY2 = "";
            int l = 2;
            foreach (GridViewRow r in gdEImage.Rows)
            {

                string chk = Request.Form["ctl00$ContentPlaceHolder1$gdEImage$ctl" + l.ToString("00") + "$EN"];

                if (chk == "1")
                {
                    Label lblDocName = (Label)r.FindControl("lblDocName");
                    Tab4DY1 = Tab4DY1 + lblDocName.Text.ToString() + ",";
                }

                else if (chk == "-1")
                {

                    Label lblDocName = (Label)r.FindControl("lblDocName");
                    Tab4DY2 = Tab4DY2 + lblDocName.Text.ToString() + ",";
                }
                else
                {
                    Label lblDocName = (Label)r.FindControl("lblDocName");
                    Tab4DY = Tab4DY + lblDocName.Text.ToString() + " , ";
                }

                l = l + 1;
            }

            ViewState["Tab4DY"] = Tab4DY.Trim();
            ViewState["GTab4"] =  Tab4DY1.ToString().Trim();
            ViewState["RTab4"] =  Tab4DY2.ToString().Trim();

           
            if (Tab1DY != "" || Tab2DY != "" || Tab3DY != "" || Tab4DY != "")
            {
                pnlMain.Attributes.Add("style", "display:none;"); ;
                pnldisplay.Attributes.Add("style", "display:none;");
                pnlunCheckData.Attributes.Add("style", "display:block;");
                pnlmsg.Attributes.Add("style", "display:none;");
                pnlVConfirm.Attributes.Add("style", "display:none;");
                lblCheckDoc.Text = "<strong> Documents need to validate. </strong> <br />" + Tab1DY + Tab2DY + Tab3DY + Tab4DY;
            }
            else
            {
                pnlMain.Attributes.Add("style", "display:none;"); ;
                pnldisplay.Attributes.Add("style", "display:none;");
                pnlunCheckData.Attributes.Add("style", "display:none;");
                pnlmsg.Attributes.Add("style", "display:none;");
                pnlVConfirm.Attributes.Add("style", "display:block;");
            }

            //pnlMain.Attributes.Add("style", "display:none;"); ;
            //pnldisplay.Attributes.Add("style", "display:none;");
            //pnlmsg.Attributes.Add("style", "display:none;");
            //pnlVConfirm.Attributes.Add("style", "display:block;");
        }

        protected void btnVNo_Click(object sender, EventArgs e)
        {
            pnlMain.Attributes.Add("style", "display:block;"); ;
            pnldisplay.Attributes.Add("style", "display:none;");
            pnlmsg.Attributes.Add("style", "display:none;");
            pnlVConfirm.Attributes.Add("style", "display:none;");
        }

        protected void btnVYes_Click(object sender, EventArgs e)
        {

            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "USP_CERPAC_DATA_NIS_L1";
                cmd.CommandType = CommandType.StoredProcedure;       

                cmd.Parameters.AddWithValue("@GTab1", ViewState["GTab1"].ToString().Trim() );
                cmd.Parameters.AddWithValue("@RTab1", ViewState["RTab1"].ToString().Trim() );
                cmd.Parameters.AddWithValue("@GTab2", ViewState["GTab2"].ToString().Trim() );
                cmd.Parameters.AddWithValue("@RTab2", ViewState["RTab2"].ToString().Trim() );

                cmd.Parameters.AddWithValue("@GTab3", ViewState["GTab3"].ToString().Trim() );
                cmd.Parameters.AddWithValue("@RTab3", ViewState["RTab3"].ToString().Trim() );
                cmd.Parameters.AddWithValue("@GTab4", ViewState["GTab4"].ToString().Trim() );
                cmd.Parameters.AddWithValue("@RTab4", ViewState["RTab4"].ToString().Trim() );

                cmd.Parameters.AddWithValue("@UserId", dt_login_details.Rows[0]["Userid"].ToString());
                cmd.Parameters.AddWithValue("@cerpacno", ViewState["Cerpac"].ToString().Trim());
                cmd.Parameters.AddWithValue("@FormNo", ViewState["FormNo"].ToString().Trim());
                cmd.Parameters.AddWithValue("@authnotes", Textarea1.Value.Trim());
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