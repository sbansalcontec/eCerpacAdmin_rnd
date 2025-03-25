using eCerpac_NIS.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing.Imaging;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCerpac_NIS
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["captchaValue"] == null)
                    GenerateCaptcha();

                lblloginmsg.InnerText = "";
                //liscencecheck();

                lblloginmsg.InnerText = Request.UserHostAddress.ToString();
                lblloginmsg.Visible = false;



                if (!IsPostBack)
                {

                    GenerateCaptcha();
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showErrorPopup", $"popmessage('error', 'Failed','Something went wrong!!');", true);
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            UserLogin_Authenticate();
        }

        protected void UserLogin_Authenticate()
        {
            if (txtUserName.Value.ToString() == "" || txtPassword.Value.ToString() == "")
            {
                lblloginmsg.Visible = true;
                lblloginmsg.Attributes.Add("style", "color:red");
                lblloginmsg.InnerText = "Please enter username or password.";
                return;
            }

            if (txtCaptcha.Text != Session["captchaValue"].ToString())
            {
                lblloginmsg.Visible = true;
                lblloginmsg.Attributes.Add("style", "color:red");
                lblloginmsg.InnerText = "Incorrect CAPTCHA";
                //ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessPopup", $"popmessage('error', 'Failed','Incorrect CAPTCHA');", true);
                return;
            }


            // string qry = "Select * from UserMaster where LoginID=@LoginId and UserStatus ='A' ";
            string qry = "Select A.*, B.ZoneCode, C.ZoneIP from UserMaster A, UserZoneRelation B, ZoneMaster C where A.UserStatus ='A' and A.LoginID=@LoginId and A.UserID= B.userid and B.ZoneCode=C.ZoneCode";
            DataTable dt = new DataTable();


            using (SqlConnection con = new SqlConnection(CommonFunctions.connection))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Parameters.AddWithValue("@LoginId", txtUserName.Value.ToString().Trim());
                        cmd.Connection = con;
                        cmd.CommandText = qry;
                        con.Open();
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);
                        con.Close();

                    }
                }
            }

            if (dt.Rows.Count > 0)
            {
                string ip = HttpContext.Current.Request.Url.Host;

                if (dt.Rows[0]["UserStatus"].ToString() != "A")
                {
                    lblloginmsg.Visible = true;
                    lblloginmsg.Attributes.Add("style", "color:red");
                    lblloginmsg.InnerText = "The application login credential has deactivated now.";
                    return;
                }
                if (dt.Rows[0]["ZoneIP"].ToString() != ip.ToString() && ip.ToString() != "localhost")
                {
                    lblloginmsg.Visible = true;
                    lblloginmsg.Attributes.Add("style", "color:red");
                    lblloginmsg.InnerText = "You are not authorized to login in this office";
                    return;
                }

                DateTime userActiveToDate;
                if (dt.Columns.Contains("userActiveToDate") && dt.Rows[0]["userActiveToDate"] != DBNull.Value)
                {
                    if (DateTime.TryParse(dt.Rows[0]["userActiveToDate"].ToString(), out userActiveToDate))
                    {
                        if (userActiveToDate < DateTime.Today)
                        {
                            lblloginmsg.Visible = true;
                            lblloginmsg.Attributes.Add("style", "color:red");
                            lblloginmsg.InnerText = "Validity of Login ID has been expired";
                            return;
                        }
                    }
                }

                String P = CommonFunctions.base64Decode(dt.Rows[0]["Password"].ToString().Trim());
                if (txtPassword.Value.ToString().Trim() == P)
                {


                    Session["LoginId"] = txtUserName.Value.ToString().Trim();
                    Session["LoginDetails"] = dt;
                    lblloginmsg.Visible = false;

                    //---------Audit Details Capture ----------------

                    string MachineIP = Request.UserHostAddress.ToString();               
                    string MachingName = System.Net.Dns.GetHostName();
                    string WindowUser = HttpContext.Current.Request.LogonUserIdentity.Name;
                    string AuditDetail = "User Login";
                    string AuditType = "10";
                    string UserID = dt.Rows[0]["Userid"].ToString();

                    string L = CommonFunctions.LoginAudit(MachineIP, MachingName, WindowUser, AuditDetail, AuditType, UserID);
                    //Server.Transfer("~/Default.aspx");
                    //if (dt.Rows[0]["GrpCode"].ToString() == "ADMN")
                    //{
                    //    Response.Redirect("~/Default.aspx");
                    //}
                    if (dt.Rows[0]["GrpCode"].ToString() == "ATHO" )
                    {
                        Response.Redirect("~/frmAuthorizationProcess.aspx");
                    }
                    if (dt.Rows[0]["GrpCode"].ToString() == "RKBE")
                    {
                        Response.Redirect("~/frmConfirmListAO.aspx");
                    }
                    if (dt.Rows[0]["GrpCode"].ToString() == "PRDO")
                    {                       
                        Response.Redirect("~/frmProductionProcess.aspx");
                    }
                    if (dt.Rows[0]["GrpCode"].ToString() == "CGNI")
                    {                       
                        Response.Redirect("~/frmNISCGApproval.aspx");
                    }

                }

                else
                {
                    lblloginmsg.Visible = true;
                    lblloginmsg.Attributes.Add("style", "color:red");
                    lblloginmsg.InnerText = "The password that you've entered is incorrect.";
                    return;
                }
            }
            else
            {
                lblloginmsg.Visible = true;
                lblloginmsg.Attributes.Add("style", "color:red");
                lblloginmsg.InnerText = "The username or password that you've entered is incorrect.";
                return;
            }
        }

        private void GenerateCaptcha()
        {
          
            try
            {
                
                Session["captchaValue"] = GenerateCaptchaCode();
                
                byte[] captchaImage =GenerateCaptchaImage(Session["captchaValue"].ToString());
                //if (txtEmail.Text != "")
                {
                    imgCaptcha.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(captchaImage);
                }
                //else
                {
                    imgCaptcha.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(captchaImage);
                }
               
            }
            catch (Exception ex)
            {
               
                ScriptManager.RegisterStartupScript(this, GetType(), "showErrorPopup", $"popmessage('error', 'Failed','Something went wrong!!');", true);
            }
        }

        public string GenerateCaptchaCode()
        {
            
            string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            Random random = new Random();
            char[] captcha = new char[6];
            for (int i = 0; i < captcha.Length; i++)
            {
                captcha[i] = chars[random.Next(chars.Length)];
            }
            string captchaCode = new string(captcha);
            return captchaCode;
        }
        public byte[] GenerateCaptchaImage(string captchaCode)
        {
            
            int width = 150;
            int height = 50;
            try
            {
                using (Bitmap bitmap = new Bitmap(width, height))
                using (Graphics graphics = Graphics.FromImage(bitmap))
                {
                    graphics.Clear(System.Drawing.Color.White);
                    DrawRandomLines(graphics, width, height);
                    using (System.Drawing.Font font = new System.Drawing.Font("Arial", 20, FontStyle.Bold))
                    using (Brush brush = new SolidBrush(System.Drawing.Color.Black))
                    {
                        graphics.TranslateTransform(0, 0);
                        graphics.RotateTransform(new Random().Next(-8, 8));
                        graphics.DrawString(captchaCode, font, brush, new PointF(8, 8));
                    }
                    DrawNoise(graphics, width, height);
                    using (MemoryStream stream = new MemoryStream())
                    {
                        bitmap.Save(stream, ImageFormat.Png);
                        byte[] captchaImage = stream.ToArray();
                        return captchaImage;
                    }
                }
            }
            catch (Exception ex)
            {
                
                throw;
            }
        }

        private void DrawRandomLines(Graphics graphics, int width, int height)
        {
            Random random = new Random();
            using (Pen pen = new Pen(System.Drawing.Color.Gray, 1))
            {
                for (int i = 0; i < 10; i++)
                {
                    graphics.DrawLine(pen, random.Next(width), random.Next(height), random.Next(width), random.Next(height));
                }
            }
        }
        private void DrawNoise(Graphics graphics, int width, int height)
        {
            Random random = new Random();
            using (Brush brush = new SolidBrush(System.Drawing.Color.LightGray))
            {
                for (int i = 0; i < 50; i++)
                {
                    graphics.FillRectangle(brush, random.Next(width), random.Next(height), 1, 1);
                }
            }
        }
        protected void btnRefreshCaptcha_Click(object sender, EventArgs e)
        {
            //CommonMethods.logger.Info("Refresh Captcha button clicked");
            GenerateCaptcha();
        }
    }
}