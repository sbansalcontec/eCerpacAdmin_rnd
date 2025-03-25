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

namespace eCerpac_NIS
{
    public partial class frmConfirmListAR01 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(CommonFunctions.connection.ToString());
        DataTable dt_login_details = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {//----------Load Fun-----------------
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
                    div_main.Attributes.Add("style", "display:block;"); ;

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
        protected void bindgrid()
        {
            string Query = "select a.cerpac_no,b.FormNo,(a.forename+' '+a.surname)as Name,a.passport_no,a.designation,nationality,ISNULL((CASE (SUBSTRING(a.cerpac_no, 1, 2)) WHEN 'AO' THEN c.company ELSE d.company END), a.verid_template_1) AS Company from People as a left join CompMaster c on a.company=c.regno LEFT OUTER JOIN CompMasterForARCR d ON a.company = d.Regno , PeopleChild as b,UserZoneRelation as e where a.cerpac_no = b.CerpacNo and b.AuthorizedBy=e.UserId  and b.IsAuthorized=1 and (ISARCR=0 or ISARCR is null) and (FORMNO Like 'AR%' ) ";
            DataTable dt = new DataTable();
            dt = CommonFunctions.fetchdata(Query);

            if (dt.Rows.Count > 0)
            {
                GridViewAuth.DataSource = dt;
                GridViewAuth.DataBind();
            }
        }

        protected void Go_Click(object sender, EventArgs e)
        {
            string Query = "select a.*,b.* from People as a , PeopleChild as b where a.cerpac_no = b.CerpacNo and a.cerpac_no='" + TextAppId.Text.ToString() + "' and b.isAuthorized =1 and(b.isARCR = 0 or b.isARCR is null) and (FORMNO Like 'AR%' )";
            DataTable dt = new DataTable();
            dt = CommonFunctions.fetchdata(Query);


            if (dt.Rows.Count > 0 && (dt.Rows[0]["ISARCR"].ToString().Trim() == "0" || dt.Rows[0]["ISARCR"].ToString().Trim() == "" || dt.Rows[0]["ISARCR"] == null) && dt.Rows[0]["IsAuthorized"].ToString().Trim() == "1")
            {
                pnlMain.Attributes.Add("style", "display:none;"); ;
                pnlDetails.Attributes.Add("style", "display:block;");
                GetData(TextAppId.Text.ToString().Trim());

                //  Response.Redirect("NISConfirmEligibility.aspx?no=" + TextAppId.Text.ToString() + "");
            }
            else if (dt.Rows.Count > 0 && dt.Rows[0]["IsARCR"].ToString() == "1")
            {
                lblmsg.Text = "This eCerpac Number Has already been Authorized";
                lblmsg.CssClass = "warning-box";
            }
            else
            {
                lblmsg.Text = "This eCerpac Number does not exists";
                lblmsg.CssClass = "warning-box";

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

            Label lblCerpacNo = (Label)GridViewAuth.SelectedRow.FindControl("lblcerpacno");
            string Query = "select a.*,b.* from People as a , PeopleChild as b where a.cerpac_no = b.CerpacNo and a.cerpac_no='" + lblCerpacNo.Text.ToString().Trim() + "' and b.isAuthorized =1 and(b.isARCR = 0 or b.isARCR is null)";
            DataTable dt = new DataTable();
            dt = CommonFunctions.fetchdata(Query);
            if (dt.Rows.Count > 0 && (dt.Rows[0]["ISARCR"].ToString().Trim() == "0" || dt.Rows[0]["ISARCR"].ToString().Trim() == "" || dt.Rows[0]["ISARCR"] == null) && dt.Rows[0]["IsAuthorized"].ToString().Trim() == "1")
            {
                pnlMain.Attributes.Add("style", "display:none;"); ;
                pnlDetails.Attributes.Add("style", "display:block;");
                GetData(lblCerpacNo.Text.ToString().Trim());

                // Response.Redirect("NISConfirmEligibility.aspx?no=" + lblCerpacNo.ToString().Trim() + "");
            }
            else if (dt.Rows.Count > 0 && dt.Rows[0]["IsARCR"].ToString() == "1")
            {
                lblmsg.Text = "This eCerpac Number Has already been Authorized";
                lblmsg.CssClass = "warning-box";
            }
            else
            {
                lblmsg.Text = "This eCerpac Number does not exists.Please check the number and try again";
                lblmsg.CssClass = "error-box";

            }
        }


        private void GetData(string ApplicationId)
        {

            string queryforcerpac = "select a.*,b.* from People as a , PeopleChild as b where a.cerpac_no = b.CerpacNo and b.IsAuthorized=1 and (b.ISARCR=0 or b.ISARCR is null) and a.cerpac_no='" + ApplicationId.ToString() + "'";
            DataTable Dt = new DataTable();
            Dt = CommonFunctions.fetchdata(queryforcerpac);

            try
            {
                if (Dt.Rows.Count > 0)
                {

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


                    TxtPassportNo.Text = Dt.Rows[0]["passport_no"].ToString().Trim();
                    TxtNationality.Text = string.Format("{0:dd/MM/yy}", Dt.Rows[0]["nationality"]).ToString().Trim();
                    TxtPassportType.Text = string.Format("{0:dd/MM/yy}", Dt.Rows[0]["passport_issue_by"]).ToString().Trim();
                    TxtDateOfIssue.Text = string.Format("{0:dd/MM/yy}", Dt.Rows[0]["passport_issue_date"]).ToString().Trim();
                    txtdoe.Text = string.Format("{0:dd/MM/yy}", Dt.Rows[0]["passport_expiry_date"]).ToString().Trim();
                    TxtPlaceOfIssue.Text = Dt.Rows[0]["passport_issue_loc"].ToString().Trim();
                    TxtFirstName.Text = Dt.Rows[0]["forename"].ToString().Trim();
                    TxtMiddleName.Text = Dt.Rows[0]["middle_name"].ToString().Trim();
                    TxtLastName.Text = Dt.Rows[0]["surname"].ToString().Trim();
                    //txtcompname.Text = Dt.Rows[0]["company"].ToString().Trim();

                    //--------------------------------------fetching company name from comp master-------------------------------


                    string queryforcomp = "Select regno,company from compmaster where regno = '" + Dt.Rows[0]["company"].ToString().Trim() + "'";
                    DataTable dtcomp = new DataTable();
                    dtcomp = CommonFunctions.fetchdata(queryforcomp);


                    if (dtcomp.Rows.Count > 0)
                    {
                        txtcompname.Text = dtcomp.Rows[0]["company"].ToString().Trim();
                        txtcompname.ToolTip = dtcomp.Rows[0]["company"].ToString().Trim();

                    }
                    else
                    {
                        txtcompid.Text = "";
                        txtcompname.Text = "";
                    }
                    //-----------------------------------------------------------------end----------------------------------------


                    txtcompadd1.Text = Dt.Rows[0]["company_add_1"].ToString().Trim();
                    txtcompadd2.Text = Dt.Rows[0]["company_add_2"].ToString().Trim();
                    txtdesig.Text = Dt.Rows[0]["designation"].ToString().Trim();
                    txtphno.Text = Dt.Rows[0]["company_tel_no"].ToString().Trim();
                    txtfaxno.Text = Dt.Rows[0]["company_fax_no"].ToString().Trim();
                    txtfileno.Text = Dt.Rows[0]["cerpac_file_no"].ToString().Trim();
                    txtemailprsn.Text = Dt.Rows[0]["Email1"].ToString().Trim();
                    txtcntcnoprsn.Text = Dt.Rows[0]["ContactNo"].ToString().Trim();

                    if (Dt.Rows[0]["sex"].ToString().Trim() == "F")
                    {
                        TxtSex.Text = "Female";
                    }
                    else
                    {

                        TxtSex.Text = "Male";
                    }
                    TxtCerpacNo.Text = Dt.Rows[0]["cerpac_no"].ToString().Trim();

                    if (Dt.Rows[0]["cerpac_receipt_date"].ToString().Trim() != null || Dt.Rows[0]["cerpac_receipt_date"].ToString().Trim() != "")
                    {
                        TxtIssueDate.Text = string.Format("{0:dd/MM/yy}", Dt.Rows[0]["cerpac_receipt_date"]).ToString().Trim();
                        TxtExpDate.Text = string.Format("{0:dd/MM/yy}", Dt.Rows[0]["cerpac_expiry_date"]).ToString().Trim();
                    }

                }
                else
                {
                    detailtable.Style.Add("display", "none");

                }
            }
            catch (Exception ex)
            {
                lblloginmsg.Text = "Error occured.Please contact system administrator. Ref No: " + ex.ToString();
                lblloginmsg.Visible = true;
            }

        }

        protected void btnverify_Click(object sender, EventArgs e)
        {
            try
            {

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "USP_CERPAC_DATA_CONFIRM";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@UserId", dt_login_details.Rows[0]["Userid"].ToString());
                cmd.Parameters.AddWithValue("@cerpacno", TxtCerpacNo.Text.ToString().Trim());
                cmd.Parameters.AddWithValue("@contecnotes", "Remark");
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

        protected void BtnDefer_Click(object sender, EventArgs e)
        {

        }

        protected void btnDenycompletely_Click(object sender, EventArgs e)
        {

        }

        protected void lnkNormal_Click(object sender, EventArgs e)
        {

        }
    }
}