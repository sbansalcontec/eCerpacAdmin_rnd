using eCerpac_NIS.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCerpac_NIS
{
    public partial class frmApplicantTracking : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(CommonFunctions.connection.ToString());
        DataTable dt_login_details = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        { //----------Load Fun-----------------
            try
            {
                if (Session["LoginId"] == null)
                {
                    Server.Transfer("Login.aspx", false);
                }

                dt_login_details = (DataTable)Session["LoginDetails"];

                if (!IsPostBack)
                {

                    ClearlabalFun();
                    DivHead.Attributes.Add("style", "display:block;"); ;
                    DivDetails.Attributes.Add("style", "display:none;"); ;


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

        public void ClearlabalFun()
        {
            lblFRMNo.Text = "";
            lblAuthBy.Text = "";
            lblAuthDt.Text = "";
            lblAuthTime.Text = "";
            lblCerpacExpDt.Text = "";
            // lblDOB.Text = "";

            lblCompanyName.Text = "";
            lblForeName.Text = "";
            lblCerpacNo.Text = "";
            lblMiddleName.Text = "";
            lblDesignation.Text = "";
            lblPassportNo.Text = "";

            lblProdBy.Text = "";
            lblProdOn.Text = "";
            lblProdTime.Text = "";
            lblQualityBy.Text = "";
            lblQualityOn.Text = "";
            lblQualTime.Text = "";

            lblStatusAC.Text = "";
            lblContecBy.Text = "";
            lblContecDt.Text = "";
            lblContecT.Text = "";

            lblSex.Text = "";
            lblStatusA.Text = "";
            lblStatusP.Text = "";
            lblStatusQ.Text = "";
            lblStatusV.Text = "";
            lblSurName.Text = "";

            lblTitle.Text = "";
            lblVerify.Text = "";
            lblVerifyDt.Text = "";
            lblVerifyTime.Text = "";
            lblZoneName.Text = "";
            lblRejectDetails.Text = "";
            lblRejectDetails.Visible = false;
            ImgPhoto.ImageUrl = "~/eImage_files/default_logo.gif";

            AuthContecOfficer.Visible = true;

            // AdminRej.Visible = false;

        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            //----------------------Flag and Auditing-----------------------
          
            string Message = string.Empty;
            try
            {
                if (txtSerach.Text != "")
                {
                 
                    string Query = "SELECT top 1 cerpac_file_no From People Where cerpac_no='" + txtSerach.Text + "' And cerpac_file_no is Not Null";
                    DataTable dt1 = new DataTable();
                    dt1 = CommonFunctions.fetchdata(Query);
                 
                    if (dt1.Rows.Count == 0)
                    {
                        FindFun();
                     
                        //Response.Write("<script>alert('Application information does not found ');</script>");

                    }
                    else if (dt1.Rows.Count > 0)
                    {
                        txtSerach.Text = dt1.Rows[0][0].ToString().Trim();
                        FindFun();

                    }
                }
            }
            catch (Exception ex)
            {

                lblloginmsg.Text = "Error occured.Please contact system administrator. Ref No: " + ex.ToString();
                lblloginmsg.CssClass = "warning-box";
                lblloginmsg.Visible = true;
            }
           
        }


        public void FindFun()
        {
         
            string Message = string.Empty;
        
            try
            {

                if (txtSerach.Text != "")
                {
                    ClearlabalFun();
                 
                    string Query = "SELECT top 1 a.FORMNO,a.CerpacNo,a.Title,a.forename, a.middle_name, a.surname, a.sex, b.company, a.designation, a.CerpacExpiry, a.DOB, a.passport_no, a.ZoneName, a.IsVerified, 	 a.Verify, a.VerifiedDate, a.VerifiedTime, a.IsAuthorized, 	 a.Auth,	a.AuthDate,	a.AuthTime,	a.IsProduced, 	a.Prod,	a.ProdDate,	a.ProdTime, a.IsQual	, a.Qual, 	 a.QualDate,	 a.QualTime,  a.IsRejected,  a.Reject, a.RejectedDate,  a.RejectedTime,	a.Rejection_Description,	a.RejectionReason, a.ISARCR, a.IsARCRUser, a.IsArCrDate, a.IsArCrTime FROM (CerpacFormNoTracking a left join compMaster b ON a.company=b.regno) where a.FORMNO='" + txtSerach.Text + "'And a.FormNo is Not Null";

                    DataTable dt = new DataTable();
                    dt = CommonFunctions.fetchdata(Query);
                   
                    if (dt.Rows.Count == 0)
                    {
                        Response.Write("<script>alert('Application information does not found ');</script>");

                        DivHead.Attributes.Add("style", "display:block;"); ;
                        DivDetails.Attributes.Add("style", "display:none;"); ;


                    }
                    else if (dt.Rows.Count > 0)
                    {
                        RejectFun();

                        //-----------Personal Details-------------
                        DivHead.Attributes.Add("style", "display:none;"); ;
                        DivDetails.Attributes.Add("style", "display:block;"); ;

                        lblFRMNo.Text = dt.Rows[0][0].ToString().Trim();
                        lblCerpacNo.Text = dt.Rows[0][1].ToString().Trim();
                        lblCerpacExpDt.Text = dt.Rows[0][9].ToString().Trim();
                        lblTitle.Text = dt.Rows[0][2].ToString().Trim();
                        lblForeName.Text = dt.Rows[0][3].ToString().Trim();
                        lblMiddleName.Text = dt.Rows[0][4].ToString().Trim();
                        lblSurName.Text = dt.Rows[0][5].ToString().Trim();
                        if ("M" == dt.Rows[0][6].ToString().Trim())
                            lblSex.Text = "Male";
                        else
                            lblSex.Text = "Female";
                        lblCompanyName.Text = dt.Rows[0][7].ToString().Trim();
                        lblDesignation.Text = dt.Rows[0][8].ToString().Trim();
                        lblPassportNo.Text = dt.Rows[0][11].ToString().Trim();

                        //29.dbo.Zonemaster.ZoneName, 
                        lblZoneName.Text = dt.Rows[0][12].ToString().Trim();
                        if (txtSerach.Text.Substring(0, 2) == "AR" || txtSerach.Text.Substring(0, 2) == "CR")
                        {
                            AuthContecOfficer.Visible = true;
                            lblSr1.Text = "1";
                            lblSr2.Text = "1";
                            lblSr3.Text = "2";
                            lblSr4.Text = "3";
                            lblSr5.Text = "4";


                        }
                        else if (txtSerach.Text.Substring(0, 2) == "AO" || txtSerach.Text.Substring(0, 2) == "AB")
                        {
                            AuthContecOfficer.Visible = true;
                            lblSr1.Text = "1";
                            lblSr2.Text = "1";
                            lblSr3.Text = "2";
                            lblSr4.Text = "3";
                            lblSr5.Text = "4";

                        }


                        //-------------- Verification ------------------

                        ////if (dt.Rows[0][12].ToString().Trim() != "" && dt.Rows[0][13].ToString().Trim() != "" && dt.Rows[0][14].ToString().Trim() != "")
                        //if ("1" == dt.Rows[0].ItemArray[13].ToString().Trim()) //IsVerified(13) ,
                        //{
                        //    lblStatusV.ForeColor = System.Drawing.Color.Green;
                        //    lblStatusV.Text = "Completed";
                        //    lblVerify.Text = dt.Rows[0][14].ToString().Trim();
                        //    lblVerifyDt.Text = dt.Rows[0][15].ToString().Trim();
                        //    lblVerifyTime.Text = dt.Rows[0][16].ToString().Trim();
                        //}

                        //else if ("0" == dt.Rows[0].ItemArray[13].ToString().Trim() ) //IsAuthorized(24), IsRejected(28) 
                        //{
                        //    lblStatusV.ForeColor = System.Drawing.Color.Red;
                        //    lblStatusV.Text = "Rejected";
                        //    lblVerify.Text = dt.Rows[0].ItemArray[30].ToString().Trim();
                        //    lblVerifyDt.Text = dt.Rows[0].ItemArray[31].ToString().Trim();
                        //    lblVerifyTime.Text = dt.Rows[0].ItemArray[32].ToString().Trim();

                        //    return;
                        //}
                        //else if ("0" == dt.Rows[0].ItemArray[13].ToString().Trim() && "0" == dt.Rows[0].ItemArray[13].ToString().Trim())
                        //{
                        //    lblStatusV.ForeColor = System.Drawing.Color.Red;
                        //    lblStatusV.Text = "Waiting";
                        //    return;
                        //}

                        //------------Authorization-------------
                        //IsAuthorized, 	 Auth,	AuthDate,	AuthTime,	

                        if ("1" == dt.Rows[0].ItemArray[17].ToString().Trim()) //IsAuthorized(17)
                        {
                            lblStatusA.ForeColor = System.Drawing.Color.Green;
                            lblStatusA.Text = "Completed";
                            lblAuthBy.Text = dt.Rows[0][18].ToString().Trim();
                            lblAuthDt.Text = dt.Rows[0][19].ToString().Trim();
                            lblAuthTime.Text = dt.Rows[0][20].ToString().Trim();
                        }
                        else if ("0" == dt.Rows[0].ItemArray[17].ToString().Trim() && "1" == dt.Rows[0].ItemArray[29].ToString().Trim()) //IsAuthorized(25), IsRejected(28) 
                        {
                            lblStatusA.ForeColor = System.Drawing.Color.Red;
                            lblStatusA.Text = "Rejected";
                            lblAuthBy.Text = dt.Rows[0].ItemArray[30].ToString().Trim();
                            lblAuthDt.Text = dt.Rows[0].ItemArray[31].ToString().Trim();
                            lblAuthTime.Text = dt.Rows[0].ItemArray[32].ToString().Trim();

                            return;
                        }
                        else if ("0" == dt.Rows[0].ItemArray[17].ToString().Trim() || "" == dt.Rows[0].ItemArray[17].ToString().Trim())
                        {
                            lblStatusA.ForeColor = System.Drawing.Color.Red;
                            lblStatusA.Text = "Waiting";
                            return;
                        }
                        //----------------ISARCR flag---------------------------
                        if ("1" == dt.Rows[0].ItemArray[35].ToString().Trim() && "AR" == dt.Rows[0].ItemArray[0].ToString().Trim().Substring(0, 2) || "1" == dt.Rows[0].ItemArray[35].ToString().Trim() && "CR" == dt.Rows[0].ItemArray[0].ToString().Trim().Substring(0, 2) || "1" == dt.Rows[0].ItemArray[35].ToString().Trim() && "AO" == dt.Rows[0].ItemArray[0].ToString().Trim().Substring(0, 2) || "1" == dt.Rows[0].ItemArray[35].ToString().Trim() && "AB" == dt.Rows[0].ItemArray[0].ToString().Trim().Substring(0, 2))
                        {
                            // AuthContecOfficer.Visible = true;
                            lblStatusAC.ForeColor = System.Drawing.Color.Green;
                            lblStatusAC.Text = "Completed";
                            lblContecBy.Text = dt.Rows[0][36].ToString().Trim();
                            lblContecDt.Text = dt.Rows[0][37].ToString().Trim();
                            lblContecT.Text = dt.Rows[0][38].ToString().Trim();

                        }
                        else if ("0" == dt.Rows[0].ItemArray[35].ToString().Trim() || "" == dt.Rows[0].ItemArray[35].ToString().Trim())
                        {
                            lblStatusAC.ForeColor = System.Drawing.Color.Red;
                            lblStatusAC.Text = "Waiting";
                            return;
                        }

                        //------------------------IsProduct =1 ----------------------------------------
                        //IsProduced, 	Prod,	ProdDate,	ProdTime, 

                        if ("1" == dt.Rows[0].ItemArray[21].ToString().Trim()) //IsProduced(26) 
                        {
                            lblStatusP.ForeColor = System.Drawing.Color.Green;
                            lblStatusP.Text = "Completed";
                            lblProdBy.Text = dt.Rows[0][22].ToString().Trim();
                            lblProdOn.Text = dt.Rows[0][23].ToString().Trim();
                            lblProdTime.Text = dt.Rows[0][24].ToString().Trim();

                        }
                        //------------------------IsProduct =2 ----------------------------------------
                        else if ("2" == dt.Rows[0].ItemArray[21].ToString().Trim()) //IsProduced(26) 
                        {
                            // GoPrev.Visible = true;
                            lblStatusP.ForeColor = System.Drawing.Color.Red;
                            lblStatusP.Text = "Waiting";
                            // lblProdBy.Text = dt.Rows[0][18].ToString().Trim();
                            // lblProdOn.Text = dt.Rows[0][19].ToString().Trim();
                            // lblProdTime.Text = dt.Rows[0][20].ToString().Trim();

                            return;

                        }
                        //------------------------IsProduct =3 ----------------------------------------
                        else if ("3" == dt.Rows[0].ItemArray[21].ToString().Trim()) //IsProduced(26) 
                        {
                            lblStatusP.ForeColor = System.Drawing.Color.Red;
                            lblStatusP.Text = "waiting";

                            return;
                        }

                        else if ("0" == dt.Rows[0].ItemArray[21].ToString().Trim() && "1" == dt.Rows[0].ItemArray[29].ToString().Trim()) //IsProduced(21) , IsRejected(29) 
                        {
                            lblStatusP.ForeColor = System.Drawing.Color.Red;
                            lblStatusP.Text = "Rejected";
                            lblProdBy.Text = dt.Rows[0].ItemArray[30].ToString().Trim();
                            lblProdOn.Text = dt.Rows[0].ItemArray[31].ToString().Trim();
                            lblProdTime.Text = dt.Rows[0].ItemArray[32].ToString().Trim();


                            return;
                        }
                        else if ("0" == dt.Rows[0].ItemArray[21].ToString().Trim() || "" == dt.Rows[0].ItemArray[21].ToString().Trim()) //IsProduced(26) , IsRejected(28) 
                        {
                            lblStatusP.ForeColor = System.Drawing.Color.Red;
                            lblStatusP.Text = "Waiting";
                            return;
                        }
                        //---------------Quality--------------------------
                        //IsQual,	 Qual, 	 QualDate,	 QualTime, 


                        if ("1" == dt.Rows[0].ItemArray[25].ToString().Trim())//IsQual(27)
                        {
                            //  AdminRej.Visible = true;
                            lblStatusQ.ForeColor = System.Drawing.Color.Green;
                            lblStatusQ.Text = "Completed";
                            lblQualityBy.Text = dt.Rows[0].ItemArray[26].ToString().Trim();
                            lblQualityOn.Text = dt.Rows[0].ItemArray[27].ToString().Trim();
                            lblQualTime.Text = dt.Rows[0].ItemArray[28].ToString().Trim();

                        }
                        else if ("0" == dt.Rows[0].ItemArray[25].ToString().Trim() && "1" == dt.Rows[0].ItemArray[29].ToString().Trim()) //IsProduced(25) , IsRejected(29) 
                        {
                            lblStatusQ.ForeColor = System.Drawing.Color.Red;
                            lblStatusQ.Text = "Rejected";
                            lblQualityBy.Text = dt.Rows[0].ItemArray[30].ToString().Trim();
                            lblQualityOn.Text = dt.Rows[0].ItemArray[31].ToString().Trim();
                            lblQualTime.Text = dt.Rows[0].ItemArray[32].ToString().Trim();

                            return;
                        }

                        else if ("0" == dt.Rows[0].ItemArray[25].ToString().Trim() || "" == dt.Rows[0].ItemArray[25].ToString().Trim())
                        {
                            lblStatusQ.ForeColor = System.Drawing.Color.Red;
                            lblStatusQ.Text = "Waiting";
                            return;
                        }
                        //-----------Regected--------------------------

                        // IsRejected,  Reject, RejectedDate,  RejectedTime,	Rejection_Description,	RejectionReason,


                        if ("1" == dt.Rows[0].ItemArray[29].ToString().Trim())//IsQual(28)
                        {
                            lblRejectDetails.ForeColor = System.Drawing.Color.Red;
                            lblRejectDetails.Text = "Regected Application :'" + dt.Rows[0].ItemArray[34].ToString().Trim() + "'";
                        }
                        else if ("0" == dt.Rows[0].ItemArray[29].ToString().Trim() || "" == dt.Rows[0].ItemArray[29].ToString().Trim())
                        {
                            lblRejectDetails.ForeColor = System.Drawing.Color.Red;
                            lblRejectDetails.Text = "";
                            return;
                        }


                        //conStr.Open();
                        //cmd.ExecuteNonQuery();

                      

                    }
                }

            }
            catch (Exception ex)
            {
                lblloginmsg.Text = "Error occured.Please contact system administrator. Ref No: " + ex.ToString();
                lblloginmsg.CssClass = "warning-box";
                lblloginmsg.Visible = true;
            }

          
        }

        protected void RejectFun()
        {
            
            try
            {


                if (txtSerach.Text != "")
                {
                 
                    string Query = "SELECT top 1  isnull(IsRejected,0) as IsRejected , Reject , RejectedDate , RejectedTime , RejectionReason FROM  CerpacFormNoTracking  Where FORMNO='" + txtSerach.Text + "'";
                    DataTable dt = new DataTable();
                    dt = CommonFunctions.fetchdata(Query);
                    if (dt.Rows.Count == 0)
                    {
                        Response.Write("<script>alert('Application information does not found ');</script>");

                    }
                    else if (dt.Rows.Count > 0)
                    {
                        //-----------Display Image----------------
                       
                        string qryimg = "select top 1 * from people where cerpac_no= (select cerpacno from peoplechild where formno='" + txtSerach.Text + "')";
                        DataTable dtimg = new DataTable();
                        dtimg = CommonFunctions.fetchdata(qryimg);


                        //----User Images---------------
                        if ((dtimg.Rows[0]["userimage"].ToString()) != "")
                        {
                            byte[] imagem = (byte[])(dtimg.Rows[0]["userimage"]);
                            string PROFILE_PIC = Convert.ToBase64String(imagem);
                            ImgPhoto.ImageUrl = String.Format("data:image/jpg;base64,{0}", PROFILE_PIC);

                        }
                        else
                        {
                            string imgPath1 = "~/eImage_files/default_logo.gif";
                            ImgPhoto.ImageUrl = "~/" + imgPath1;

                        }





                        //     Reject(29) , RejectedDate(30) ,RejectedTime(31) , Rejection_Description(32)  
                        if ("1" == dt.Rows[0].ItemArray[0].ToString().Trim())//IsQual(28)
                        {
                            lblRejectDetails.Visible = true;
                            lblRejectDetails.ForeColor = System.Drawing.Color.Red;
                            lblRejectDetails.Text = "Rejection:'" + dt.Rows[0].ItemArray[4].ToString().Trim() + "'";
                        }
                        else if ("0" == dt.Rows[0].ItemArray[0].ToString().Trim() || "" == dt.Rows[0].ItemArray[0].ToString().Trim())
                        {
                            lblRejectDetails.ForeColor = System.Drawing.Color.Red;
                            lblRejectDetails.Text = "";
                            return;
                        }

                    }
                }

            }
            catch (Exception ex)
            {
                lblloginmsg.Text = "Error occured.Please contact system administrator. Ref No: " + ex.ToString();
                lblloginmsg.CssClass = "warning-box";
                lblloginmsg.Visible = true;
            }
            
        }


    }
}