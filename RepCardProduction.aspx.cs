using eCerpac_NIS.App_Code;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

namespace eCerpac_NIS
{
    public partial class RepCardProduction : System.Web.UI.Page
    {
        SqlConnection cn1 = new SqlConnection(CommonFunctions.connection.ToString());
        DataTable dt_login_details = new DataTable();


        protected DataTable objDs = new DataTable();
        protected DataTable objDsRep = new DataTable();

        protected DataTable objSDs = new DataTable();
        protected DataTable objSDsRep = new DataTable();
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
                    DD_Monthbind();
                    pnlMain.Attributes.Add("style", "display:block;"); ;
                    pnlDetails.Attributes.Add("style", "display:block;"); ;
                }

                lblloginmsg.InnerHtml = "";
            }

            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }

        }


        private void DD_Monthbind()
        {
            DateTime dateofBirth = DateTime.MinValue;

            System.Globalization.DateTimeFormatInfo info = System.Globalization.DateTimeFormatInfo.GetInstance(null);
            int currentMonth = DateTime.Now.Month;
            for (int i = currentMonth; i < 13; i++)
            {
                ddlMonth.Items.Add(new ListItem(info.GetMonthName(i), i.ToString()));
            }

            ddlMonth.DataBind();

            ddlYear.DataSource =  Enumerable.Range(DateTime.Now.Year - 10, 11).Reverse();
            ddlYear.DataBind();

            ddlMonth.SelectedValue = dateofBirth.Month.ToString();
            ddlYear.SelectedValue = dateofBirth.Year.ToString();

          

            //System.Globalization.DateTimeFormatInfo info = System.Globalization.DateTimeFormatInfo.GetInstance(null);
            //int currentMonth = DateTime.Now.Month;
            //for (int i = currentMonth; i < 13; i++)
            //{
            //    drpMonth.Items.Add(new ListItem(info.GetMonthName(i), i.ToString()));
            //}

            //if (DateTime.Now.Day <= 10)
            //{
            //    drpMonth.Items.Insert(0, new ListItem(info.GetMonthName(currentMonth - 1), currentMonth.ToString()));
            //}

            //if (drpMonth.Items.FindByValue(currentMonth.ToString()) != null)
            //{
            //    drpMonth.Items.FindByValue(currentMonth.ToString()).Selected = true;
            //}
        }

   


        protected void BtnSearchOpt(object sender, EventArgs e)
        {
            try
            {
                if (IsPostBack)
                {
                   // pnlDetails.Visible = false;
                    //pnlDetails.Attributes.Remove("class");


                    //------------Filter Conditions-----------------

                    string condition = "", Case = "", Heading = "";


                   // lblfilter.Text = Heading.ToString().ToUpper(); ;
                    //lblRFilter.Text = Heading.ToString().ToUpper(); ;


  string            qry = "SELECT Title,people_id ,tile1, (forename + ' ' + surname) AS Name,sex,cerpac_no,cerpac_file_no,cerpac_receipt_date , picture    ,cerpac_expiry_date,registration_area,registration_code,file_no,passport_no,nationality,passport_issue_date,passport_expiry_date " +
                               ",passport_issue_loc,passport_issue_by,date_of_birth,place_of_birth,nigeria_add_1,nigeria_add_2,nigeria_tel_no,abroad_add_1     ,abroad_add_2,abroad_tel_no,company,company_add_1,company_add_2,designation,employment_date,company_tel_no,company_fax_no " +
                               ",email,verid_template,ContactNo,userImage,IsVerified,IsAuthorized,IsProduced,VerifiedBy,AuthorizedBy,ProducedBy     ,ProducedOn,AuthorizedOn,VerifiedOn,IsRejected,RejectedBy,RejectedOn,RejectionReason,ZoneNote,AuthNote,ProdNote,QualNote " +
                               ",IsDependent,DesignationCode,DependentOn,ISARCR,ConfirmedBy,ConfirmedOn,Cerpac_ExpiryDt,Cerpac_IssuedDt,IsQual,QualBy,QualOn,CompanyName    ,date_system_modified ,  ProdDate " +
                               " FROM vw_ApplicantDetails order by year(ProdDate), month(ProdDate), day(ProdDate)";

                    // EducationLevel,InstitutionName, IsCompleted,DegreeCompletedOn,

                    DataTable dtR = new DataTable();
                    dtR = CommonFunctions.fetchdata(qry);
                    objDs = dtR;

                    if (dtR.Rows.Count > 0)
                    {
                        Session["RegReportS"] = dtR;
                        // lbl_total.Text = dtR.Rows.Count.ToString();
                        //pnlMain.Attributes.Add("style", "display:block;");

                        //pnlDetails.Visible = true;
                        //pnlDetails.Attributes.Add("class", "active");

                    }
                    else
                    {

                       // lbl_total.Text = dtR.Rows.Count.ToString();

                    }


                }
            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please check database connection details !" + " </h4>";
            }


        }


        protected void BtnPrinter(object sender, EventArgs e)
        {

            if (Session["RegReportS"] != null)
            {

                objDs = (DataTable)Session["RegReportS"];
                objDsRep = (DataTable)Session["RegReportS"];

                ScriptManager.RegisterStartupScript(this, GetType(), "key", "PrintContent();", true);
            }

        }




        public void ExportToExcel(ref string html, string fileName)
        {
            Label LabelMessage = (Label)this.Page.Master.FindControl("lblmsg");
            string Message = string.Empty;

            try
            {
                html = html.Replace("&gt;", ">");
                html = html.Replace("&lt;", "<");
                HttpContext.Current.Response.ClearContent();
                HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + fileName + "_" + DateTime.Now.ToString("M_dd_yyyy_H_M_s") + ".xls");
                HttpContext.Current.Response.ContentType = "application/xls";
                HttpContext.Current.Response.Write(html);
                HttpContext.Current.Response.End();
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnExcel_Click(object sender, EventArgs e)
        {
            Label LabelMessage = (Label)this.Page.Master.FindControl("lblmsg");
            string Message = string.Empty;


            try
            {

                if (Session["RegReportS"] != null)
                {
                   
                    objDs = (DataTable)Session["RegReportS"];
                    objDsRep = (DataTable)Session["RegReportS"];

                    // ScriptManager.RegisterStartupScript(this, GetType(), "key", "PrintContentSummary();", true);
                    string html = HdnValue.Value;
                    ExportToExcel(ref html, "eCERPAC Production Report");
                }


            }

            catch (Exception ex)
            {

            }
        }

        protected void btn_generate_Click(object sender, EventArgs e)
        {
            try
            {
                if (IsPostBack)
                {
                    // pnlDetails.Visible = false;
                    //pnlDetails.Attributes.Remove("class");


                    //------------Filter Conditions-----------------

                    string condition = "", Case = "", Heading = "";


                    // lblfilter.Text = Heading.ToString().ToUpper(); ;
                    //lblRFilter.Text = Heading.ToString().ToUpper(); ;


                    string qry = "SELECT Title,people_id ,tile1, (forename + ' ' + surname) AS Name,sex,cerpac_no,cerpac_file_no,cerpac_receipt_date , picture    ,cerpac_expiry_date,registration_area,registration_code,file_no,passport_no,nationality,passport_issue_date,passport_expiry_date " +
                                                 ",passport_issue_loc,passport_issue_by,date_of_birth,place_of_birth,nigeria_add_1,nigeria_add_2,nigeria_tel_no,abroad_add_1     ,abroad_add_2,abroad_tel_no,company,company_add_1,company_add_2,designation,employment_date,company_tel_no,company_fax_no " +
                                                 ",email,verid_template,ContactNo,userImage,IsVerified,IsAuthorized,IsProduced,VerifiedBy,AuthorizedBy,ProducedBy     ,ProducedOn,AuthorizedOn,VerifiedOn,IsRejected,RejectedBy,RejectedOn,RejectionReason,ZoneNote,AuthNote,ProdNote,QualNote " +
                                                 ",IsDependent,DesignationCode,DependentOn,ISARCR,ConfirmedBy,ConfirmedOn,Cerpac_ExpiryDt,Cerpac_IssuedDt,IsQual,QualBy,QualOn,CompanyName    ,date_system_modified ,  ProdDate " +
                                                 " FROM vw_ApplicantDetails where ProdDate between '"+ fromDateInput.Value + "' and '"+ toDateInput.Value + "' order by year(ProdDate), month(ProdDate), day(ProdDate)";

                    // EducationLevel,InstitutionName, IsCompleted,DegreeCompletedOn,

                    DataTable dtR = new DataTable();
                    dtR = CommonFunctions.fetchdata(qry);
                    objDs = dtR;

                    if (dtR.Rows.Count > 0)
                    {
                        lblmsg.Visible = false;
                        lblmsg.InnerText = "";

                        Session["RegReportS"] = dtR;
                        lblmsg.Visible = false;
                        btn_Print.Visible = true;
                        R1.Attributes.Add("style", "overflow-x: scroll; background-color: white; height: 350px;display:block;");

                    }
                    else
                    {
                        lblmsg.Visible = true;
                        btn_Print.Visible = false;
                        lblmsg.InnerText = "No Record Found";
                        R1.Attributes.Add("style", "overflow-x: scroll; background-color: white; height: 350px;display:none;");
                      

                    }


                }
            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please check database connection details !" + " </h4>";
            }

        }
    }
}