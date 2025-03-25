using eCerpac_NIS.App_Code;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCerpac_NIS
{
    public partial class frmCheckSheetReports : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(CommonFunctions.connection.ToString());
        DataTable dt_login_details = new DataTable();

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
                   

                    DetailPage.Attributes.Add("style", "display:block;"); ;
                    div_main.Attributes.Add("style", "display:none;");
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

        protected void btn_generate_report_Click(object sender, EventArgs e)
        {
            if (txtCerpacNo.Value != "")
            {
             
               
                string qry = "Select isnull(a.cerpac_file_no,'') From people a, peoplechild b where a.cerpac_file_no=b.FORMNO and a.cerpac_no ='" + txtCerpacNo.Value + "'";

                DataTable dtC = new DataTable();
                dtC = CommonFunctions.fetchdata(qry);
                if (dtC.Rows.Count > 0)
                {
                    string FormNo = dtC.Rows[0][0].ToString().Trim();
                    if (FormNo != "")
                    {
                        FillCheckSheet();
                        lblGetDate.Text = String.Format("{0:dd-MMM-yyyy}", DateTime.Today);
                    }
                }
                else
                {
                    div_main.Visible = false;
                    Response.Write("<script>alert('Please enter cerpac no. only');</script>");
                    return;
                }

            }
            else
            {
                div_main.Visible = false;
                Response.Write("<script>alert('Please enter cerpac no. only');</script>");
                return;
            }
        }


        public void FillCheckSheet()
        {
          
            string query1 = "(SELECT isnull(b.Title,''), a.forename, a.middle_name, a.surname, a.residence_permit_no, a.residence_issue_loc, a.sex, a.cerpac_no,isnull (Convert(varchar(11),a.cerpac_receipt_date,106),' '), isnull(Convert(varchar(11),a.cerpac_expiry_date,106),' '), a.cerpac_file_no, a.file_no, a.deedmark_no, a.issue_no, a.passport_no, a.nationality, isnull ( Convert(varchar(11),a.passport_issue_date,106),' ') , isnull( Convert(varchar(11),a.passport_expiry_date,106),' '), a.passport_issue_loc, a.passport_issue_by, isnull(Convert(varchar(11),a.date_of_birth,106),' ') , a.place_of_birth, a.nigeria_add_1, a.nigeria_add_2, a.nigeria_tel_no, a.abroad_add_1, a.abroad_add_2, a.abroad_tel_no, ISNULL((CASE (SUBSTRING(a.cerpac_no, 1, 2)) WHEN 'AO' THEN c.company ELSE d.company END), a.verid_template_1) AS Company, a.company_add_1, a.company_add_2, a.designation, isnull( Convert(varchar(11),a.employment_date,106),' '), a.company_tel_no, a.company_fax_no, a.email, a.verid_template_1 from people as a Left Outer Join TitleMaster as b  ON  a.Title=b.TitleCode left join CompMaster c on a.company=c.regno LEFT OUTER JOIN CompMasterForARCR d ON a.company = d.Regno Where  a.Cerpac_No='" + txtCerpacNo.Value + "')";

            DataTable dt = new DataTable();
            dt = CommonFunctions.fetchdata(query1);
            if (dt.Rows.Count == 0)
            {
                dt.Rows.Clear();
                div_main.Visible = false;
                Response.Write("<script>alert('Secure sold form no. does not found');</script>");
                return;

            }
            else if (dt.Rows.Count > 0)
            {
                div_main.Visible = true;
                //-----------Personal Details-------------
                lblTile.Text = dt.Rows[0][0].ToString().Trim();
                lblForeName.Text = dt.Rows[0][1].ToString().Trim();
                lblMiddleName.Text = dt.Rows[0][2].ToString().Trim();
                lblSurName.Text = dt.Rows[0][3].ToString().Trim();
                //lblResidencePermitNo.Text = dt.Rows[0][4].ToString().Trim();
                //lblPlaceofIssue.Text = dt.Rows[0][5].ToString().Trim();

                lblSex.Text = dt.Rows[0][6].ToString().Trim();

                if (lblSex.Text != "") { if (dt.Rows[0][6].ToString().Trim() == "F") lblSex.Text = "Female"; else if (dt.Rows[0][6].ToString().Trim() == "M") lblSex.Text = "Male"; }

                //----------Cerpac Details-----------------
                lblCerpacNo.Text = dt.Rows[0][7].ToString().Trim();
                lblDateofReceipt.Text = dt.Rows[0][8].ToString().Trim();
                lblDateofExpiry.Text = dt.Rows[0][9].ToString().Trim();
                lblFileNo.Text = dt.Rows[0][10].ToString().Trim();
                lblFileN.Text = dt.Rows[0][11].ToString().Trim();
                //lblWatermarkNo.Text = dt.Rows[0][12].ToString().Trim();
                lblIssueNo.Text = dt.Rows[0][13].ToString().Trim();
                //-------------Condition for Issue no ------------------------
                if (lblCerpacNo.Text.Trim() != lblFileNo.Text.Trim())
                {
                    FillIssue();
                }
                else if (lblCerpacNo.Text.Trim() == lblFileNo.Text.Trim())
                {
                    lblFileNo.Text = "";
                }

                //----------Passport Details--------------
                lblPassportNo.Text = dt.Rows[0][14].ToString().Trim();
                lblNationality.Text = dt.Rows[0][15].ToString().Trim();
                lblDateofIssueP.Text = dt.Rows[0][16].ToString().Trim();
                lblDateofExpiryP.Text = dt.Rows[0][17].ToString().Trim();
                lblPlaceofIssueP.Text = dt.Rows[0][18].ToString().Trim();
                lblIssuedByP.Text = dt.Rows[0][19].ToString().Trim();
                lblDateofBirth.Text = dt.Rows[0][20].ToString().Trim();
                lblPlaceofBirth.Text = dt.Rows[0][21].ToString().Trim();

                //-------------Address Details------------------
                lblNigeriaAdd1.Text = dt.Rows[0][22].ToString().Trim();
                lblNigeriaAdd2.Text = dt.Rows[0][23].ToString().Trim();
                lblNigeriaTelNo.Text = dt.Rows[0][24].ToString().Trim();
                lblAbroadAdd1.Text = dt.Rows[0][25].ToString().Trim();
                lblAbroadAdd2.Text = dt.Rows[0][26].ToString().Trim();
                lblAbroadTelNo.Text = dt.Rows[0][27].ToString().Trim();

                ////------------Company Details------------- 

                lblCompanyName.Text = dt.Rows[0][28].ToString().Trim();

                ////-----------------------------------------

                lblCompanyAdd1.Text = dt.Rows[0][29].ToString().Trim();
                lblCompanyAdd2.Text = dt.Rows[0][30].ToString().Trim();
                lblDesgination.Text = dt.Rows[0][31].ToString().Trim();
                lblDateofemployement.Text = dt.Rows[0][32].ToString().Trim();
                lblTelNo.Text = dt.Rows[0][33].ToString().Trim();
                lblFaxNo.Text = dt.Rows[0][34].ToString().Trim();
                lblEmail.Text = dt.Rows[0][35].ToString().Trim();

                DetailPage.Attributes.Add("style", "display:none;"); ;
                div_main.Attributes.Add("style", "display:block;");
                //----------------Details  -------------
                dt.Rows.Clear();
            }
        }


        public void FillIssue()
        {
         
            string query1 = "(Select Count(*), cerpac_no From Issue where cerpac_no= '" + txtCerpacNo.Value + "' Group by cerpac_no)";

            DataTable dti = new DataTable();
            dti = CommonFunctions.fetchdata(query1);
            if (dti.Rows.Count > 0)
            {
                lblIssueNo.Text = dti.Rows[0][0].ToString().Trim();
            }
        }
    }
}