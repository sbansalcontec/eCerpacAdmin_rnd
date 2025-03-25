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
    public partial class frmConfirmListAO01 : System.Web.UI.Page
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
                qry = " Select  A.cerpac_no, (A.forename+' '+A.surname)as Name, A.cerpac_file_no as FORMNO, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) as Status   " +
                   " from vw_ApplicantDetails A LEFT OUTER JOIN vw_ApplicantDocument B ON A.cerpac_file_no=B.Form_No where isnull(A.IsAuthorized,0)=1  and  isnull(A.ISARCR,0) =0   group by  A.CreatedOn, A.cerpac_no, (A.forename+' '+A.surname) , A.cerpac_file_no, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) " +
                   " order by " + Condition + "  ";
            }
            else
            {

                qry = " Select  A.cerpac_no, (A.forename+' '+A.surname)as Name, A.cerpac_file_no as FORMNO, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) as Status   " +
                 " from vw_ApplicantDetails A LEFT OUTER JOIN vw_ApplicantDocument B ON A.cerpac_file_no=B.Form_No where isnull(A.IsAuthorized,0)=1  and  isnull(A.ISARCR,0) =0  group by  A.CreatedOn, A.cerpac_no, (A.forename+' '+A.surname) , A.cerpac_file_no, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) " +
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
            string Query = "select a.*,b.* from People as a , PeopleChild as b where a.cerpac_no = b.CerpacNo and a.cerpac_no='" + TextAppId.Text.ToString() + "' and b.isAuthorized =1 and(b.isARCR = 0 or b.isARCR is null) and (FORMNO Like 'AO%' or FORMNO Like 'CR%' or FORMNO Like 'AB%')";
            DataTable dt = new DataTable();
            dt = CommonFunctions.fetchdata(Query);
            DataTable dtuser = new DataTable();
            if (dt.Rows.Count > 0 && (dt.Rows[0]["ISARCR"].ToString().Trim() == "0" || dt.Rows[0]["ISARCR"].ToString().Trim() == "" || dt.Rows[0]["ISARCR"] == null) && dt.Rows[0]["IsAuthorized"].ToString().Trim() == "1" )
            {
                pnlMain.Attributes.Add("style", "display:none;"); ;
                pnlDetails.Attributes.Add("style", "display:block;"); ;
                GetData(TextAppId.Text.ToString().Trim());

                // Response.Redirect("FrmConfirmEligibilityAO.aspx?no=" + TextAppId.Text.ToString() + "");
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
                    e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(GridViewCntcAuthAO, "Select$" + e.Row.RowIndex);
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

        protected void GridViewCntcAuthAO_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                //Reference the GridView Row.
                GridViewRow row = GridViewCntcAuthAO.Rows[rowIndex];
            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }
        }

        protected void GridViewCntcAuthAO_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label lblCerpacNo = (Label)GridViewCntcAuthAO.SelectedRow.FindControl("lblcerpacno");
            string Query = "select a.*,b.* from People as a , PeopleChild as b where a.cerpac_no = b.CerpacNo and a.cerpac_no='" + lblCerpacNo.Text.ToString().Trim() + "'and b.isAuthorized =1 and(b.isARCR = 0 or b.isARCR is null)";
            DataTable dt = new DataTable();
            dt = CommonFunctions.fetchdata(Query);
           
            if (dt.Rows.Count > 0 && (dt.Rows[0]["ISARCR"].ToString().Trim() == "0" || dt.Rows[0]["ISARCR"].ToString().Trim() == "" || dt.Rows[0]["ISARCR"] == null) && dt.Rows[0]["IsAuthorized"].ToString().Trim() == "1" )
            {
                pnlMain.Attributes.Add("style", "display:none;"); ;
                pnlDetails.Attributes.Add("style", "display:block;"); ;
                GetData(lblCerpacNo.Text.ToString().Trim());

               // Response.Redirect("FrmConfirmEligibilityAO.aspx?no=" + lblCerpacNo.ToString().Trim() + "");
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

        protected void btnVerify_Click(object sender, EventArgs e)
        {

            pnlMain.Attributes.Add("style", "display:none;"); ;
            pnlDetails.Attributes.Add("style", "display:none;");
            pnlmsg.Attributes.Add("style", "display:none;");
            pnlVConfirm.Attributes.Add("style", "display:block;");


        }

        protected void btnDefer_Click(object sender, EventArgs e)
        {

        }

        protected void btnDenycompletely_Click(object sender, EventArgs e)
        {

        }



        private void GetData(string ApplicationId)
        {
       
            string Query = "select a.*,b.* from People as a , PeopleChild as b where a.cerpac_no = b.CerpacNo and b.IsAuthorized=1  and (b.ISARCR=0 or b.ISARCR is null) and a.cerpac_no='" + ApplicationId.ToString() + "'";
    
            DataTable Dt = new DataTable();
            Dt = CommonFunctions.fetchdata(Query);
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
                    txtPeoplename.Text = Dt.Rows[0]["forename"].ToString().Trim() + " " + Dt.Rows[0]["middle_name"].ToString().Trim() + " " + Dt.Rows[0]["surname"].ToString().Trim();
                    txtfrnno.Text = Dt.Rows[0]["cerpac_file_no"].ToString().Trim();
                    TxtCerpacNo.Text = Dt.Rows[0]["cerpac_no"].ToString().Trim();
                    lblPeopleCerpac.Text = Dt.Rows[0]["cerpac_no"].ToString().Trim();
                    lblPeopleNationlaity.Text = Dt.Rows[0]["nationality"].ToString().Trim();
                    lblPeoplePassportNo.Text = Dt.Rows[0]["passport_no"].ToString().Trim();
                    //--------------------------------------fetching company name from comp master-------------------------------
                    
                    string queryforcomp = "Select regno,company from compmaster where regno = '" + Dt.Rows[0]["company"].ToString().Trim() + "'";

                    DataTable dtcomp = new DataTable();
                    dtcomp = CommonFunctions.fetchdata(queryforcomp);
                    if (dtcomp.Rows.Count > 0)
                    {
                        txtPeolpeCompany.Text = dtcomp.Rows[0]["company"].ToString().Trim();
                        txtPeolpeCompany.ToolTip = dtcomp.Rows[0]["company"].ToString().Trim();

                    }
                    else
                    {
                        //txtcompid.Text = "";
                        txtPeolpeCompany.Text = "";
                    }
                    //-----------------------------------------------------------------end----------------------------------------
                    //------------------------------------------------------------code to fetch expiry date from view----------------------------------------------
                    string expdtquery = "Select * from vw_prod_consolidated_data where  IsAuthorized='1' and (IsARCR is null or IsARCR = '0' or IsARCR='') and (IsProduced is null or IsProduced = '0' or IsProduced='') and cerpac_no='" + TxtCerpacNo.Text.ToString().Trim() + "' ";
                    DataTable dtexpdt = new DataTable();
                    dtexpdt = CommonFunctions.fetchdata(expdtquery);
                    if (dtexpdt.Rows.Count > 0)
                    {
                        lblexp.Text = string.Format("{0:d-MM-yyyy}", dtexpdt.Rows[0]["cerpac_expiry_date"]).ToString().Trim();
                        lblrcpt.Text = string.Format("{0:d-MM-yyyy}", dtexpdt.Rows[0]["cerpac_receipt_date"]).ToString().Trim();
                    }
                    //---------------------------------------------------------------------end---------------------------------------------------------------------
                    //---------------------------------------------------------code to fetch the number of forms --------------------------------------------
                    string numquery = "select * from PeopleChild  where IsAuthorized=1 and (ISARCR=0 or ISARCR is null) and cerpacno='" + ApplicationId.ToString() + "'";
                    DataTable dtnum = new DataTable();
                    dtnum = CommonFunctions.fetchdata(numquery);
                    if (dtnum.Rows.Count > 0)
                    {
                        lblnum.Text = dtnum.Rows.Count.ToString();
                        if (dtnum.Rows.Count == 1)
                        {
                            txtfrnnoorig.Text = dtnum.Rows[0]["FORMNO"].ToString();
                        }
                        else
                        {
                            string frnfinal = "";
                            for (int i = 0; i < dtnum.Rows.Count; i++)
                            {
                                frnfinal = dtnum.Rows[i]["FORMNO"].ToString() + "," + frnfinal.ToString();

                            }
                            txtfrnnoorig.Text = frnfinal.Substring(0, frnfinal.Length - 1);
                        }

                        bankdetails(txtfrnnoorig.Text.ToString().Trim());
                    }
                    else
                    {
                        lblnum.Text = "0";
                    }
                    //-----------------------------------------------------------------------end-------------------------------------------------------------

                    //-------------------------------------------------code to check the fresh or renewal case-------------------------------------------------
                    string newrenewquery = "Select * from Issue where cerpac_no='" + TxtCerpacNo.Text.ToString().Trim() + "'";
                    DataTable dtnewrenew = new DataTable();
                    dtnewrenew = CommonFunctions.fetchdata(newrenewquery);
                    if (dtnewrenew.Rows.Count > 0)
                    {
                        lblnewrenew.Text = "Renewal";
                    }
                    else
                    {
                        lblnewrenew.Text = "Fresh";
                    }
                    //----------------------------------------------------------end-----------------------------------------------------------------------

                    //--------------------------------------------- data from bank-------------------------------------------
                    string queryforbankdetails = "Select * from Uploaded_excel_data where FORMNO='" + txtfrnno.Text.ToString().Trim() + "'";
                  
                    DataTable dtbnk = new DataTable();
                    dtbnk = CommonFunctions.fetchdata(queryforbankdetails);
                    if (dtbnk.Rows.Count > 0)
                    {
                        // lblform1.Text = txtfrnno.Text.ToString().Trim();
                        //txtbankname.Text = dtbnk.Rows[0]["FirstName"].ToString() + " " + dtbnk.Rows[0]["LastName"].ToString();
                        // txtcompanybank.Text = dtbnk.Rows[0]["COMPANY"].ToString();
                        lblprchase.Text = string.Format("{0:d-MM-yyyy}", dtbnk.Rows[0]["Date1"]).ToString().Trim().Replace('-', '/');
                        // lblBankNationality.Text = dtbnk.Rows[0]["nationality"].ToString();
                    }
                    //--------------------------------------------------end--------------------------------------------------
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


        public void bankdetails(string data)
        {
            if (data.ToString() != "")
            {
                string querytxt = data.ToString();
                // string[] formnos = new string[10];
                //formnos = querytxt.Split(',');
                string formnos = "";
                formnos = querytxt.Replace(",", "','");

                string query = "Select formno, (FirstName+' '+LastName) as Name, NATIONALITY, Passportno, Company from uploaded_excel_Data where FORMNO in ('" + formnos.ToString().Trim() + "')";
                DataTable dtfrms = new DataTable();
                dtfrms = CommonFunctions.fetchdata(query);
                if (dtfrms.Rows.Count > 0)
                {
                    DataList1.DataSource = dtfrms;

                    DataList1.DataBind();


                }
              
            }
            else
            {

            }


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