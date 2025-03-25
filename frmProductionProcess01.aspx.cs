using eCerpac_NIS.App_Code;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Security.Policy;
using System.Threading;
using System.Drawing.Imaging;
using ZXing.QrCode;
using ZXing;
using System.Xml.Linq;
using System.Configuration;
using System.Net.Mail;
using System.Net;

namespace eCerpac_NIS
{
    public partial class frmProductionProcess01 : System.Web.UI.Page
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
                    bindgrid();

                    pnlMain.Attributes.Add("style", "display:block;"); ;
                    pnldisplay.Attributes.Add("style", "display:none;");
                    pnlCard.Attributes.Add("style", "display:none;");


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

             string queryforposition = "Select forename as FirstName, middle_name as MiddleName, surname as  LastName, CompanyName, Nationality, cerpac_file_no as FormNo, cerpac_no, Passport_No from vw_ApplicantDetails  where (IsAuthorized=1)   and ISARCR=1 and (IsProduced=0 or IsProduced is null or IsProduced=2 or IsProduced=3 or IsProduced=4) ";
         //  // string queryforposition = "Select A.cerpac_no, (A.forename+' '+A.surname)as Name, A.cerpac_file_no as FORMNO, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) as Status   from vw_ApplicantDetails A " +
           // //    " LEFT OUTER JOIN vw_ApplicantDocument B ON A.cerpac_file_no=B.Form_No where (IsAuthorized=1)   and ISARCR=1 and (IsProduced=0 or IsProduced is null or IsProduced=2 or IsProduced=3 or IsProduced=4)   group by A.cerpac_no, (A.forename+' '+A.surname) , A.cerpac_file_no, A.CompanyName, (Case when A.cerpac_no= A.cerpac_file_no then 'Fresh Case' Else 'Renewal Case' End) ";
            
            DataTable dt1 = new DataTable();
            dt1 = CommonFunctions.fetchdata(queryforposition);


            if (dt1.Rows.Count > 0)
            {
                grd_display_data.DataSource = dt1;
                grd_display_data.DataBind();
            }
            else
            {

                grd_display_data.DataSource = dt1;
                grd_display_data.DataBind();

            }


        }
        protected void Go_Click(object sender, EventArgs e)
        {

            try
            {
                // string quer = "select * from vw_prod_consolidated_data a, UserZoneRelation b where (IsAuthorized=1) and (isarcr=1) and (IsProduced=0 or IsProduced is null or IsProduced=2 or IsProduced=3 or IsProduced=4) and a.verifiedby = b.userid  and b.ZoneCode=(select ZoneCode from UserZoneRelation where USERID=" + objectSessionHolderPersistingData.User_ID + ") and cerpacno='" + TextAppId.Text.ToString() + "'";
                //string quer = "Select forename as FirstName, middle_name as MiddleName, surname as  LastName, Company, Nationality, cerpac_file_no as FormNo, cerpac_no, Passport_No from vw_ApplicantDetails  where (IsAuthorized=1)   and ISARCR=1 and (IsProduced=0 or IsProduced is null or IsProduced=2 or IsProduced=3 or IsProduced=4) and cerpac_no='" + TextAppId.Text.ToString() + "'";

                string qry = "SELECT Title,people_id ,tile1,forename,middle_name,surname,sex,cerpac_no,cerpac_file_no,cerpac_receipt_date , picture    ,cerpac_expiry_date,registration_area,registration_code,file_no,passport_no,nationality,passport_issue_date,passport_expiry_date " +
                  ",passport_issue_loc,passport_issue_by,date_of_birth,place_of_birth,nigeria_add_1,nigeria_add_2,nigeria_tel_no,abroad_add_1     ,abroad_add_2,abroad_tel_no,company,company_add_1,company_add_2,designation,employment_date,company_tel_no,company_fax_no " +
                  ",email,verid_template,ContactNo,userImage,IsVerified,IsAuthorized,IsProduced,VerifiedBy,AuthorizedBy,ProducedBy     ,ProducedOn,AuthorizedOn,VerifiedOn,IsRejected,RejectedBy,RejectedOn,RejectionReason,ZoneNote,AuthNote,ProdNote,QualNote " +
                  ",IsDependent,DesignationCode,DependentOn,ISARCR,ConfirmedBy,ConfirmedOn,Cerpac_ExpiryDt,Cerpac_IssuedDt,IsQual,QualBy,QualOn,CompanyName    ,date_system_modified  " +
                  " FROM vw_ApplicantDetails where cerpac_no='" + TextAppId.Text.ToString() + "'";

                
                DataTable Dt = new DataTable();
                Dt = CommonFunctions.fetchdata(qry);

                if (Dt.Rows.Count > 0)
                {
                    string ApplicationId = Dt.Rows[0]["cerpac_no"].ToString();
                  
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
                    txtcompid.Text = Dt.Rows[0]["company"].ToString().Trim();


                    //--------------------------------------fetching company name from comp master-------------------------------

                    string queryforcomp = "";
                    if (ApplicationId.Substring(0, 2) == "AO")
                    {
                        queryforcomp = "Select regno,company from compmaster where regno = '" + Dt.Rows[0]["company"].ToString().Trim() + "'";
                    }
                    else
                    {
                        queryforcomp = "Select regno,company from CompMasterForARCR where regno = '" + Dt.Rows[0]["company"].ToString().Trim() + "'";
                    }

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
                    txtemailprsn.Text = Dt.Rows[0]["email"].ToString().Trim();
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
                    else
                    {
                        TxtIssueDate.Text = "-----";
                        TxtExpDate.Text = "-----";
                    }

                    pnlMain.Attributes.Add("style", "display:none;"); ;
                    pnldisplay.Attributes.Add("style", "display:block;");
                    pnlCard.Attributes.Add("style", "display:none;");


                }
                else
                {
                    lblmsg.Text = "eCerpac Number has not been verified or not exist or Already Produced.";
                    lblmsg.CssClass = "warning-box";
                    detailtable.Style.Add("display", "none");


                    //  warn.Style.Add("display", "");
                }
            }
            catch (Exception ex)
            {
                lblloginmsg.Text = "Error occured.Please contact system administrator. Ref No: " + ex.ToString();
                lblloginmsg.CssClass = "warning-box";
            }
           
        }

        protected void grd_display_data_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grd_display_data.PageIndex = e.NewPageIndex;
            this.bindgrid();
        }

        protected void grd_display_data_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(grd_display_data, "Select$" + e.Row.RowIndex);
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

        protected void grd_display_data_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                //Reference the GridView Row.
                GridViewRow row = grd_display_data.Rows[rowIndex];
            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }
        }

        protected void grd_display_data_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
              
                GridViewRow row = grd_display_data.SelectedRow;

                string lblCerpac = row.Cells[6].Text;
                string qry = "SELECT Title,people_id ,tile1,forename,middle_name,surname,sex,cerpac_no,cerpac_file_no,cerpac_receipt_date , picture    ,cerpac_expiry_date,registration_area,registration_code,file_no,passport_no,nationality,passport_issue_date,passport_expiry_date " +
                                 ",passport_issue_loc,passport_issue_by,date_of_birth,place_of_birth,nigeria_add_1,nigeria_add_2,nigeria_tel_no,abroad_add_1     ,abroad_add_2,abroad_tel_no,company,company_add_1,company_add_2,designation,employment_date,company_tel_no,company_fax_no " +
                                 ",email,verid_template,ContactNo,userImage,IsVerified,IsAuthorized,IsProduced,VerifiedBy,AuthorizedBy,ProducedBy     ,ProducedOn,AuthorizedOn,VerifiedOn,IsRejected,RejectedBy,RejectedOn,RejectionReason,ZoneNote,AuthNote,ProdNote,QualNote " +
                                 ",IsDependent,DesignationCode,DependentOn,ISARCR,ConfirmedBy,ConfirmedOn,Cerpac_ExpiryDt,Cerpac_IssuedDt,IsQual,QualBy,QualOn,CompanyName    ,date_system_modified  " +
                                 " FROM vw_ApplicantDetails where cerpac_no='" + lblCerpac.ToString() + "'";

                DataTable Dt = new DataTable();
                Dt = CommonFunctions.fetchdata(qry);

                if (Dt.Rows.Count > 0)
                {
                    string ApplicationId = Dt.Rows[0]["cerpac_no"].ToString();

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
                    txtcompid.Text = Dt.Rows[0]["company"].ToString().Trim();


                    //--------------------------------------fetching company name from comp master-------------------------------

                    string queryforcomp = "";
                    if (ApplicationId.Substring(0, 2) == "AO")
                    {
                        queryforcomp = "Select regno,company from compmaster where regno = '" + Dt.Rows[0]["company"].ToString().Trim() + "'";
                    }
                    else
                    {
                        queryforcomp = "Select regno,company from CompMasterForARCR where regno = '" + Dt.Rows[0]["company"].ToString().Trim() + "'";
                    }

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
                    txtemailprsn.Text = Dt.Rows[0]["email"].ToString().Trim();
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
                    else
                    {
                        TxtIssueDate.Text = "-----";
                        TxtExpDate.Text = "-----";
                    }

                 
                    pnlMain.Attributes.Add("style", "display:none;"); ;
                    pnldisplay.Attributes.Add("style", "display:block;");
                    pnlCard.Attributes.Add("style", "display:none;;");

                }
                else
                {
                    lblmsg.Text = "eCerpac Number has not been verified or not exist or Already Produced.";
                    detailtable.Style.Add("display", "none");


                    //  warn.Style.Add("display", "");
                }
            }
            catch (Exception ex)
            {
                lblloginmsg.Text = "Error occured.Please contact system administrator. Ref No: " + ex.ToString();
                lblloginmsg.CssClass = "warning-box";
            }
        }

        protected void btnCardGen_Click(object sender, EventArgs e)
        {
          
       
            try
            {
                     CultureInfo c = Thread.CurrentThread.CurrentCulture;
                TextInfo textInfo = c.TextInfo;
                string qry = "SELECT Title,people_id ,tile1,forename,middle_name,surname,sex,cerpac_no,cerpac_file_no,cerpac_receipt_date , picture    ,cerpac_expiry_date,registration_area,registration_code,file_no,passport_no,nationality,passport_issue_date,passport_expiry_date " +
                                 ",passport_issue_loc,passport_issue_by,date_of_birth,place_of_birth,nigeria_add_1,nigeria_add_2,nigeria_tel_no,abroad_add_1     ,abroad_add_2,abroad_tel_no,company,company_add_1,company_add_2,designation,employment_date,company_tel_no,company_fax_no " +
                                 ",email,verid_template,ContactNo,userImage,IsVerified,IsAuthorized,IsProduced,VerifiedBy,AuthorizedBy,ProducedBy     ,ProducedOn,AuthorizedOn,VerifiedOn,IsRejected,RejectedBy,RejectedOn,RejectionReason,ZoneNote,AuthNote,ProdNote,QualNote " +
                                 ",IsDependent,DesignationCode,DependentOn,ISARCR,ConfirmedBy,ConfirmedOn,Cerpac_ExpiryDt,Cerpac_IssuedDt,IsQual,QualBy,QualOn,CompanyName    ,date_system_modified " +
                                 " FROM vw_ApplicantDetails where cerpac_no='" + TxtCerpacNo.Text.ToString() + "'";

                DataTable Dt = new DataTable();
                Dt = CommonFunctions.fetchdata(qry);

                if (Dt.Rows.Count > 0)
                {
                    string ApplicationId = Dt.Rows[0]["cerpac_no"].ToString();

                    //----User Images---------------
                    if ((Dt.Rows[0]["userimage"].ToString()) != "")
                    {
                        byte[] imagem = (byte[])(Dt.Rows[0]["userimage"]);
                        string PROFILE_PIC = Convert.ToBase64String(imagem);
                        Image1.ImageUrl = String.Format("data:image/jpg;base64,{0}", PROFILE_PIC);

                    }
                    else
                    {
                        string imgPath1 = "~/eImage_files/default_logo.gif";
                        Image1.ImageUrl = "~/" + imgPath1;

                    }



                    lbl_name.Text = textInfo.ToTitleCase((Dt.Rows[0]["forename"].ToString() + " " + Dt.Rows[0]["surname"].ToString()).ToLower());
                    lbl_passport.Text = Dt.Rows[0]["passport_no"].ToString().ToUpper();
                    txt_comps.Text = Dt.Rows[0]["CompanyName"].ToString().ToUpper();
                    lbl_desig.Text = textInfo.ToTitleCase((Dt.Rows[0]["designation"].ToString()).ToLower());
                    lbl_dob.Text = string.Format("{0:d-MM-yyyy}", Dt.Rows[0]["date_of_birth"]).ToString().Trim();
                  
                    lbl_nationality.Text = textInfo.ToTitleCase((Dt.Rows[0]["nationality"].ToString()).ToUpper());
                    lbl_date_of_issue.Text = string.Format("{0:d-MM-yyyy}", Dt.Rows[0]["cerpac_receipt_date"]).ToString().Trim();
                    lbl_expiry_date.Text = string.Format("{0:d-MM-yyyy}", Dt.Rows[0]["cerpac_expiry_date"]).ToString();

                    String cer_no = Dt.Rows[0]["cerpac_no"].ToString().Substring(0, 1).ToUpper() + Dt.Rows[0]["cerpac_no"].ToString().Substring(1);
                    lbl_cerpac_no.Text = Dt.Rows[0]["cerpac_no"].ToString().ToUpper();
                    lbl_cerpac_file_no.Text = Dt.Rows[0]["cerpac_file_no"].ToString().ToUpper();
                    GenerateCode(Dt.Rows[0]["passport_no"].ToString().ToUpper(), Dt.Rows[0]["forename"].ToString() + " " + Dt.Rows[0]["surname"].ToString(), string.Format("{0:d-MM-yyyy}", Dt.Rows[0]["date_of_birth"]).ToString().Trim(), string.Format("{0:d-MM-yyyy}", Dt.Rows[0]["cerpac_receipt_date"]).ToString().Trim(), string.Format("{0:d-MM-yyyy}", Dt.Rows[0]["cerpac_expiry_date"]).ToString().Trim(),
                        Dt.Rows[0]["CompanyName"].ToString().ToUpper(), Dt.Rows[0]["cerpac_no"].ToString().ToUpper(), Dt.Rows[0]["designation"].ToString().ToUpper());


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

                    pnlMain.Attributes.Add("style", "display:none;"); ;
                    pnldisplay.Attributes.Add("style", "display:none;;");
                    pnlCard.Attributes.Add("style", "display:block;");


                }


            }
            catch (Exception ex)
            {
                lblloginmsg.Text = "Error occured.Please contact system administrator. Ref No: " + ex.ToString();
                lblloginmsg.CssClass = "warning-box"; 
           
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

        private void SendMail()
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
                               " FROM vw_ApplicantDetails where cerpac_no='" + lbl_cerpac_no.Text.ToString().Trim() + "' and cerpac_file_no='" + lbl_cerpac_file_no.Text.ToString().Trim() + "'";



            DataTable dt = new DataTable();
            dt = CommonFunctions.fetchdata(qry);

            if (dt.Rows.Count > 0)
            {
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

    

    protected void btn_back_Click(object sender, EventArgs e)
        {
            pnlMain.Attributes.Add("style", "display:block;"); ;
            pnldisplay.Attributes.Add("style", "display:none;");
            pnlCard.Attributes.Add("style", "display:none;");
        }

        protected void btnBack1_Click(object sender, EventArgs e)
        {
            pnlMain.Attributes.Add("style", "display:none;"); ;
            pnldisplay.Attributes.Add("style", "display:block;");
            pnlCard.Attributes.Add("style", "display:none;");

            SendMail();
        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {

            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "USP_CERPAC_CardProd";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@UserId", dt_login_details.Rows[0]["Userid"].ToString());
                cmd.Parameters.AddWithValue("@cerpacno", lbl_cerpac_no.Text.ToString().Trim());
                cmd.Parameters.AddWithValue("@prodnotes", "Remark");
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



            //--------Send Mail--------
        }
    }
}