using eCerpac_NIS.App_Code;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Runtime.ConstrainedExecution;
using System.IO;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.TreeView;
using System.Xml.Linq;
using System.Web.UI.HtmlControls;

namespace eCerpac_NIS
{
    public partial class frmConfirmListAO : System.Web.UI.Page
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
                    pnlDetails.Attributes.Add("style", "display:none;");
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

        protected void bindgrid(string sortExpression = null)
        {
            string Condition = "";

            if (currentSortColumn.ToString() != "")
                Condition = Condition + currentSortColumn + " ";

            if (currentSortColumn.ToString() != "" && currentSortOrder.ToString() == "ASC")
                Condition = Condition + " asc  ";
            else if (currentSortColumn.ToString() != "" && currentSortOrder.ToString() == "DESC")
                Condition = Condition + " desc  ";


            // string Query = " Select A.cerpac_no, (A.forename+' '+A.surname)as Name, A.cerpac_file_no as FORMNO, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) as Status   from vw_ApplicantDetails A, vw_ApplicantDocument B where A.cerpac_file_no=B.Form_No and isnull(A.IsAuthorized,0)=1  and  isnull(A.ISARCR,0) =0  " +
            //     " group by A.cerpac_no, (A.forename+' '+A.surname) , A.cerpac_file_no, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) ";

            string qry = "";
            if (Condition != String.Empty)
            {
                qry = " Select  A.cerpac_no, (A.forename+' '+A.surname)as Name, A.cerpac_file_no as FORMNO, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) as Status,Confirmedby, A.CreatedOn  " +
                   " from vw_ApplicantDetails A LEFT OUTER JOIN vw_ApplicantDocument B ON A.cerpac_file_no=B.Form_No where a.cerpac_file_no not like 'AR%' and isnull(A.IsAuthorized,'0')='1'  and  (isnull(A.ISARCR,'0') ='0' or isnull(A.IsProduced,'0')='2')   group by  A.CreatedOn, A.cerpac_no, (A.forename+' '+A.surname),Confirmedby , A.cerpac_file_no, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) " +
                   " order by " + Condition + "  ";
            }
            else
            {

                qry = " Select  A.cerpac_no, (A.forename+' '+A.surname)as Name, A.cerpac_file_no as FORMNO, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) as Status,Confirmedby , A.CreatedOn  " +
                 " from vw_ApplicantDetails A LEFT OUTER JOIN vw_ApplicantDocument B ON A.cerpac_file_no=B.Form_No where  a.cerpac_file_no not like 'AR%' and isnull(A.IsAuthorized,'0')='1'  and  (isnull(A.ISARCR,'0') ='0' or isnull(A.IsProduced,'0')='2')  group by  A.CreatedOn, A.cerpac_no, (A.forename+' '+A.surname) , A.cerpac_file_no, A.CompanyName,Confirmedby, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) " +
                " order by   A.CreatedOn desc ";

            }

            DataTable dt = new DataTable();
            dt = CommonFunctions.fetchdata(qry);

            if (dt.Rows.Count > 0)
            {
                GridViewCntcAuthAO.DataSource = dt;
                GridViewCntcAuthAO.DataBind();
            }
            else
            {
                GridViewCntcAuthAO.DataSource = null;
                GridViewCntcAuthAO.DataBind();
            }
        }


        protected void Go_Click(object sender, EventArgs e)
        {
           
            try
            {


                string qry = " Select  A.cerpac_no, (A.forename+' '+A.surname)as Name, A.cerpac_file_no as FORMNO, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) as Status   " +
    " from vw_ApplicantDetails A LEFT OUTER JOIN vw_ApplicantDocument B ON A.cerpac_file_no=B.Form_No where a.cerpac_file_no not like 'AR%' and  isnull(A.IsAuthorized,0)=1  and  isnull(A.ISARCR,0) =0  and ( A.cerpac_no like '" + TextAppId.Text.ToString() + "%' or A.cerpac_file_no like '" + TextAppId.Text.ToString() + "%' ) " +
    " group by  A.CreatedOn, A.cerpac_no, (A.forename+' '+A.surname) , A.cerpac_file_no, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) " +
    " order by A.CreatedOn desc ";


                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(qry);

                if (dt.Rows.Count > 0)
                {
                    Session["GridViewCntcAuthAO"] = dt;
                    //lbl_total.Text = dt.Rows.Count.ToString();
                    GridViewCntcAuthAO.DataSource = dt;
                    GridViewCntcAuthAO.DataBind();
                }
                else
                {
                    //lbl_total.Text = dt.Rows.Count.ToString();
                    GridViewCntcAuthAO.DataSource = null;
                    GridViewCntcAuthAO.DataBind();
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

        protected void GridViewCntcAuthAO_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewCntcAuthAO.PageIndex = e.NewPageIndex;
            this.bindgrid();
        }

        protected void GridViewCntcAuthAO_RowDataBound(object sender, GridViewRowEventArgs e)
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
                    string columnNameValue = rowView["Confirmedby"].ToString();

                    if (columnNameValue == dt_login_details.Rows[0]["Userid"].ToString() || columnNameValue == "")
                    {
                        e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(GridViewCntcAuthAO, "Select$" + e.Row.RowIndex);
                        e.Row.Attributes["style"] = "cursor:pointer";
                    }
                    else
                    {
                        ImageButton imgBtnAssign = (ImageButton)e.Row.FindControl("imgBtnAssign");
                        imgBtnAssign.Enabled = false;
                        imgBtnAssign.ImageUrl = "~/eImage_files/Task_assigned.jpg";
                        e.Row.ToolTip = "Already assigned to another one";
                        e.Row.BackColor = System.Drawing.Color.LightCoral;
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

        protected void GridViewCntcAuthAO_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "Assign")
                {
                    string cerpacNo = e.CommandArgument.ToString(); // Get CerpacNo directly
                    bindgrid_assign(cerpacNo);
                }
                else
                {
                    int rowIndex = Convert.ToInt32(e.CommandArgument);

                    //Reference the GridView Row.
                    GridViewRow row = GridViewCntcAuthAO.Rows[rowIndex];

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

        public void bindgrid_assign(string lblCerpacNo)
        {
            try
            {
                //Label lblCerpacNo = (Label)GridViewCntcAuthAO.SelectedRow.FindControl("lblcerpacno");

                string Qty1 = "SELECT Title,people_id ,Category_Type ,tile1,forename,middle_name,surname,sex,cerpac_no,cerpac_file_no,cerpac_receipt_date , picture    ,cerpac_expiry_date,registration_area,registration_code,file_no,passport_no,nationality,passport_issue_date,passport_expiry_date " +
                    ",passport_issue_loc,passport_issue_by,date_of_birth,place_of_birth,nigeria_add_1,nigeria_add_2,nigeria_tel_no,abroad_add_1     ,abroad_add_2,abroad_tel_no,company,company_add_1,company_add_2,designation,employment_date,company_tel_no,company_fax_no " +
                    ",email,verid_template,ContactNo,userImage,IsVerified,IsAuthorized,IsProduced,VerifiedBy,AuthorizedBy,ProducedBy     ,ProducedOn,AuthorizedOn,VerifiedOn,IsRejected,RejectedBy,RejectedOn,RejectionReason,ZoneNote,AuthNote,ProdNote,QualNote " +
                    ",IsDependent,DesignationCode,DependentOn,ISARCR,ConfirmedBy,ConfirmedOn,Cerpac_ExpiryDt,Cerpac_IssuedDt,IsQual,QualBy,QualOn,CompanyName    ,convert(varchar(10), date_system_modified ,103) as date_system_modified ,AppType,PaymentMode1 " +
                    " FROM vw_ApplicantDetails where cerpac_no='" + lblCerpacNo.ToString().Trim() + "'";

                DataTable Dt = new DataTable();
                Dt = CommonFunctions.fetchdata(Qty1);
                string Cerpac = "", FormNo = "";
                if (Dt.Rows.Count > 0)
                {
                    if (Dt.Rows[0]["ConfirmedBy"].ToString().Trim() != "" && Dt.Rows[0]["ConfirmedBy"].ToString().Trim() != dt_login_details.Rows[0]["Userid"].ToString())
                    {
                        lblloginmsg.Attributes.Add("class", "active");
                        lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                        lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Already assigned to another one !" + " </h4>";
                        return;
                    }

                    string updateQuery = "UPDATE peoplechild " +
                                     "SET ConfirmedBy = @VerifiedBy, ConfirmedOn = GETDATE() " +
                                     "WHERE FormNo = @FormNo";

                    using (SqlCommand updateCmd = new SqlCommand(updateQuery, con))
                    {
                        con.Open();
                        updateCmd.Parameters.AddWithValue("@VerifiedBy", dt_login_details.Rows[0]["Userid"].ToString());
                        updateCmd.Parameters.AddWithValue("@FormNo", lblCerpacNo.ToString().Trim());
                        int rowsAffected = updateCmd.ExecuteNonQuery();
                        con.Close();
                    }

                    //----User Images---------------
                    if ((Dt.Rows[0]["userimage"].ToString()) != "")
                    {
                        byte[] imagem = (byte[])(Dt.Rows[0]["userimage"]);
                        string PROFILE_PIC = Convert.ToBase64String(imagem);
                        ImgPhoto.ImageUrl = String.Format("data:image/jpg;base64,{0}", PROFILE_PIC);

                    }
                    else
                    {
                        string imgPath1 = "~/eImage_files/default_logo.gif";
                        ImgPhoto.ImageUrl = "~/" + imgPath1;

                    }

                    HlblTitle.Text = Dt.Rows[0]["title"].ToString().Trim();
                    lblPaymentMode.Text = Dt.Rows[0]["PaymentMode1"].ToString().Trim();
                    HlblFristName.Text = Dt.Rows[0]["forename"].ToString().Trim();
                    HlblLastName.Text = Dt.Rows[0]["surname"].ToString().Trim();
                    lblSubmissionDate.Text = Dt.Rows[0]["date_system_modified"].ToString().Trim();

                    lblApplicantType.Text = Dt.Rows[0]["AppType"].ToString().Trim();
                    lblCerpacNo1.Text = Dt.Rows[0]["cerpac_no"].ToString().Trim();
                    lblCerpacNo2.Text = Dt.Rows[0]["cerpac_no"].ToString().Trim();
                    lblDBName.Text = Dt.Rows[0]["forename"].ToString().Trim() + " " + Dt.Rows[0]["surname"].ToString().Trim();

                    lblDBNationality.Text = Dt.Rows[0]["nationality"].ToString().Trim();
                    lblDBPassportNo.Text = Dt.Rows[0]["passport_no"].ToString().Trim();
                    lblDBCompany.Text = Dt.Rows[0]["CompanyName"].ToString().Trim();

                    FormNo = Dt.Rows[0]["cerpac_file_no"].ToString().Trim();
                    ViewState["FormNo"] = FormNo.Trim();

                    lblCategory.Text = Dt.Rows[0]["Category_Type"].ToString().Trim();
                    lblCIssueDate.Text = Dt.Rows[0]["cerpac_receipt_date"].ToString().Trim();
                    lblCExpiryDate.Text = Dt.Rows[0]["cerpac_expiry_date"].ToString().Trim();

                    //--------------------------------------------- data from bank-------------------------------------------
                    string Qty2 = "Select * from Uploaded_excel_data where FORMNO='" + FormNo + "'";

                    DataTable dtB = new DataTable();
                    dtB = CommonFunctions.fetchdata(Qty2);
                    if (dtB.Rows.Count > 0)
                    {
                        lblFormNo.Text = dtB.Rows[0]["Formno"].ToString().Trim();
                        lblBKName.Text = dtB.Rows[0]["FirstName"].ToString().Trim() + " " + dtB.Rows[0]["LastName"].ToString().Trim();

                        lblBKNationality.Text = dtB.Rows[0]["nationality"].ToString().Trim();
                        lblBKPassportNo.Text = dtB.Rows[0]["passportno"].ToString().Trim();
                        lblBKCompany.Text = dtB.Rows[0]["COMPANY"].ToString().Trim();
                    }

                    //--------------------------------------------------end--------------------------------------------------

                    if (lblFormNo.Text.Trim() == lblCerpacNo1.Text.Trim())
                        ImgForm.Src = "~/eImage_files/yes.png";
                    else if (lblFormNo.Text.Trim() == string.Empty)
                    {
                        lblFormNo.Text = "Not Found";
                        ImgForm.Src = "~/eImage_files/no.png";
                    }


                    if (lblDBName.Text.Trim() == lblBKName.Text.Trim())
                        ImgName.Src = "~/eImage_files/yes.png";
                    else if (lblBKName.Text.Trim() == string.Empty)
                    {
                        lblBKName.Text = "Not Found";
                        ImgForm.Src = "~/eImage_files/no.png";
                    }

                    if (lblDBPassportNo.Text.Trim() == lblBKPassportNo.Text.Trim())
                        ImgPassport.Src = "~/eImage_files/yes.png";
                    else if (lblBKPassportNo.Text.Trim() == string.Empty)
                    {
                        lblBKPassportNo.Text = "Not Found";
                        ImgForm.Src = "~/eImage_files/no.png";
                    }
                    if (lblDBNationality.Text.Trim() == lblBKNationality.Text.Trim())
                        ImgNationality.Src = "~/eImage_files/yes.png";
                    else if (lblBKNationality.Text.Trim() == string.Empty)
                    {
                        lblBKNationality.Text = "Not Found";
                        ImgForm.Src = "~/eImage_files/no.png";
                    }

                    if (lblDBCompany.Text.Trim() == lblBKCompany.Text.Trim())
                        ImgCompany.Src = "~/eImage_files/yes.png";
                    else if (lblBKCompany.Text.Trim() == string.Empty)
                    {
                        lblBKCompany.Text = "Not Found";
                        ImgForm.Src = "~/eImage_files/no.png";
                    }
                }

                //-------------L2 commit need to display---------------


                string Qty3 = "Select A.AuthNote, B.Username  from peoplechild A, usermaster B where A.AuthorizedBy=B.UserID and A.Cerpacno ='" + lblCerpacNo.ToString().Trim() + "' " +
                    " and A.formno='" + FormNo.ToString().Trim() + "' and isAuthorized=1";



                DataTable DtC = new DataTable();
                DtC = CommonFunctions.fetchdata(Qty3);

                if (DtC.Rows.Count > 0)
                {
                    lblName.Text = DtC.Rows[0]["Username"].ToString().Trim();
                    lblCommet.Text = DtC.Rows[0]["AuthNote"].ToString().Trim();
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

                pnlMain.Attributes.Add("style", "display:none;"); ;
                pnlDetails.Attributes.Add("style", "display:block;"); ;


                // Response.Redirect("FrmConfirmEligibilityAO.aspx?no=" + lblCerpacNo.ToString().Trim() + "");

            }
            catch (Exception ex)
            {
                throw (ex);
            }
        }

        protected void GridViewCntcAuthAO_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Label lblCerpacNo = (Label)GridViewCntcAuthAO.SelectedRow.FindControl("lblcerpacno");

                string Qty1 = "SELECT Title,people_id ,Category_Type ,tile1,forename,middle_name,surname,sex,cerpac_no,cerpac_file_no,cerpac_receipt_date , picture    ,cerpac_expiry_date,registration_area,registration_code,file_no,passport_no,nationality,passport_issue_date,passport_expiry_date " +
                    ",passport_issue_loc,passport_issue_by,date_of_birth,place_of_birth,nigeria_add_1,nigeria_add_2,nigeria_tel_no,abroad_add_1     ,abroad_add_2,abroad_tel_no,company,company_add_1,company_add_2,designation,employment_date,company_tel_no,company_fax_no " +
                    ",email,verid_template,ContactNo,userImage,IsVerified,IsAuthorized,IsProduced,VerifiedBy,AuthorizedBy,ProducedBy     ,ProducedOn,AuthorizedOn,VerifiedOn,IsRejected,RejectedBy,RejectedOn,RejectionReason,ZoneNote,AuthNote,ProdNote,QualNote " +
                    ",IsDependent,DesignationCode,DependentOn,ISARCR,ConfirmedBy,ConfirmedOn,Cerpac_ExpiryDt,Cerpac_IssuedDt,IsQual,QualBy,QualOn,CompanyName    ,convert(varchar(10), date_system_modified ,103) as date_system_modified ,AppType,PaymentMode1 " +
                    " FROM vw_ApplicantDetails where cerpac_no='" + lblCerpacNo.Text.ToString().Trim() + "'";

                DataTable Dt = new DataTable();
                Dt = CommonFunctions.fetchdata(Qty1);
                string Cerpac = "", FormNo = "";
                if (Dt.Rows.Count > 0)
                {
                    if (Dt.Rows[0]["ConfirmedBy"].ToString().Trim() != "" && Dt.Rows[0]["ConfirmedBy"].ToString().Trim() != dt_login_details.Rows[0]["Userid"].ToString())
                    {
                        lblloginmsg.Attributes.Add("class", "active");
                        lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                        lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Already assigned to another one !" + " </h4>";
                        return;
                    }

                    string updateQuery = "UPDATE peoplechild " +
                                     "SET ConfirmedBy = @VerifiedBy, ConfirmedOn = GETDATE() " +
                                     "WHERE FormNo = @FormNo";

                    using (SqlCommand updateCmd = new SqlCommand(updateQuery, con))
                    {
                        con.Open();
                        updateCmd.Parameters.AddWithValue("@VerifiedBy", dt_login_details.Rows[0]["Userid"].ToString());
                        updateCmd.Parameters.AddWithValue("@FormNo", lblCerpacNo.Text.ToString().Trim());
                        int rowsAffected = updateCmd.ExecuteNonQuery();
                        con.Close();
                    }

                    //----User Images---------------
                    if ((Dt.Rows[0]["userimage"].ToString()) != "")
                    {
                        byte[] imagem = (byte[])(Dt.Rows[0]["userimage"]);
                        string PROFILE_PIC = Convert.ToBase64String(imagem);
                        ImgPhoto.ImageUrl = String.Format("data:image/jpg;base64,{0}", PROFILE_PIC);

                    }
                    else
                    {
                        string imgPath1 = "~/eImage_files/default_logo.gif";
                        ImgPhoto.ImageUrl = "~/" + imgPath1;

                    }
                
                    HlblTitle.Text = Dt.Rows[0]["title"].ToString().Trim();
                    lblPaymentMode.Text = Dt.Rows[0]["PaymentMode1"].ToString().Trim();
                    HlblFristName.Text = Dt.Rows[0]["forename"].ToString().Trim();
                    HlblLastName.Text = Dt.Rows[0]["surname"].ToString().Trim();
                    lblSubmissionDate.Text = Dt.Rows[0]["date_system_modified"].ToString().Trim();
                   
                    lblApplicantType.Text = Dt.Rows[0]["AppType"].ToString().Trim();
                    lblCerpacNo1.Text = Dt.Rows[0]["cerpac_no"].ToString().Trim();
                    lblCerpacNo2.Text = Dt.Rows[0]["cerpac_no"].ToString().Trim();
                    lblDBName.Text =  Dt.Rows[0]["forename"].ToString().Trim() + " " + Dt.Rows[0]["surname"].ToString().Trim();

                    lblDBNationality.Text = Dt.Rows[0]["nationality"].ToString().Trim();
                    lblDBPassportNo.Text = Dt.Rows[0]["passport_no"].ToString().Trim();
                    lblDBCompany.Text = Dt.Rows[0]["CompanyName"].ToString().Trim();

                    FormNo= Dt.Rows[0]["cerpac_file_no"].ToString().Trim();
                    ViewState["FormNo"] = FormNo.Trim();

                    lblCategory.Text = Dt.Rows[0]["Category_Type"].ToString().Trim();
                    lblCIssueDate.Text = Dt.Rows[0]["cerpac_receipt_date"].ToString().Trim();
                    lblCExpiryDate.Text = Dt.Rows[0]["cerpac_expiry_date"].ToString().Trim();

                    //--------------------------------------------- data from bank-------------------------------------------
                    string Qty2 = "Select * from Uploaded_excel_data where FORMNO='" + FormNo + "'";

                    DataTable dtB = new DataTable();
                    dtB = CommonFunctions.fetchdata(Qty2);
                    if (dtB.Rows.Count > 0)
                    {
                        lblFormNo.Text = dtB.Rows[0]["Formno"].ToString().Trim();
                        lblBKName.Text = dtB.Rows[0]["FirstName"].ToString().Trim() + " " + dtB.Rows[0]["LastName"].ToString().Trim() ;

                        lblBKNationality.Text = dtB.Rows[0]["nationality"].ToString().Trim();
                        lblBKPassportNo.Text = dtB.Rows[0]["passportno"].ToString().Trim();
                        lblBKCompany.Text = dtB.Rows[0]["COMPANY"].ToString().Trim();
                    }
                    
                    //--------------------------------------------------end--------------------------------------------------

                    if (lblFormNo.Text.Trim() == lblCerpacNo1.Text.Trim())
                        ImgForm.Src = "~/eImage_files/yes.png";
                    else if (lblFormNo.Text.Trim() == string.Empty)
                    {
                        lblFormNo.Text = "Not Found";
                        ImgForm.Src = "~/eImage_files/no.png";
                    }


                    if (lblDBName.Text.Trim() == lblBKName.Text.Trim())
                        ImgName.Src = "~/eImage_files/yes.png";
                    else if (lblBKName.Text.Trim() == string.Empty)
                    {
                        lblBKName.Text = "Not Found";
                        ImgForm.Src = "~/eImage_files/no.png";
                    }

                    if (lblDBPassportNo.Text.Trim() == lblBKPassportNo.Text.Trim())
                        ImgPassport.Src = "~/eImage_files/yes.png";
                    else if (lblBKPassportNo.Text.Trim() == string.Empty)
                    {
                        lblBKPassportNo.Text = "Not Found";
                        ImgForm.Src = "~/eImage_files/no.png";
                    }
                    if (lblDBNationality.Text.Trim() == lblBKNationality.Text.Trim())
                        ImgNationality.Src = "~/eImage_files/yes.png";
                    else if (lblBKNationality.Text.Trim() == string.Empty)
                    {
                        lblBKNationality.Text = "Not Found";
                        ImgForm.Src = "~/eImage_files/no.png";
                    }

                    if (lblDBCompany.Text.Trim() == lblBKCompany.Text.Trim())
                        ImgCompany.Src = "~/eImage_files/yes.png";
                    else if (lblBKCompany.Text.Trim() == string.Empty)
                    {
                        lblBKCompany.Text = "Not Found";
                        ImgForm.Src = "~/eImage_files/no.png";
                    }
                }

                //-------------L2 commit need to display---------------


                string Qty3 = "Select A.AuthNote, B.Username  from peoplechild A, usermaster B where A.AuthorizedBy=B.UserID and A.Cerpacno ='" + lblCerpacNo.Text.ToString().Trim() + "' " +
                    " and A.formno='" + FormNo.ToString().Trim() + "' and isAuthorized=1";



                DataTable DtC = new DataTable();
                DtC = CommonFunctions.fetchdata(Qty3);
              
                if (DtC.Rows.Count > 0)
                {
                    lblName.Text = DtC.Rows[0]["Username"].ToString().Trim();
                    lblCommet.Text= DtC.Rows[0]["AuthNote"].ToString().Trim();
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

                pnlMain.Attributes.Add("style", "display:none;"); ;
                pnlDetails.Attributes.Add("style", "display:block;"); ;


                // Response.Redirect("FrmConfirmEligibilityAO.aspx?no=" + lblCerpacNo.ToString().Trim() + "");

            }
            catch (Exception ex)
            {
                throw (ex);
            }
        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {

            pnlMain.Attributes.Add("style", "display:none;"); ;
            pnlDetails.Attributes.Add("style", "display:none;");
            pnlmsg.Attributes.Add("style", "display:none;");
            pnlVConfirm.Attributes.Add("style", "display:block;");


        }

     



       


       
        protected void btnVYes_Click(object sender, EventArgs e)
        {
            try
            {

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "USP_CERPAC_DATA_CONFIRM";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@UserId", dt_login_details.Rows[0]["Userid"].ToString());
                cmd.Parameters.AddWithValue("@cerpacno", lblCerpacNo1.Text.ToString().Trim());
                cmd.Parameters.AddWithValue("@FormNo", ViewState["FormNo"].ToString().Trim());
                cmd.Parameters.AddWithValue("@contecnotes", txtcomment.Value.Trim());
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
                    pnlDetails.Attributes.Add("style", "display:none;");
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

        protected void btnVNo_Click(object sender, EventArgs e)
        {
            pnlMain.Attributes.Add("style", "display:block;"); ;
            pnlDetails.Attributes.Add("style", "display:none;");
            pnlmsg.Attributes.Add("style", "display:none;");
            pnlVConfirm.Attributes.Add("style", "display:none;");
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

                GridViewCntcAuthAO.SelectedIndex = -1;
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
                Position(GridViewCntcAuthAO, sortOrder, currentSortColumn);
            else
                Position(GridViewCntcAuthAO, sortOrder, currentSortColumn);
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



    }
}