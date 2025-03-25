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
    public partial class frmChangePassword : System.Web.UI.Page
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
                    txtLoginId.Text = dt_login_details.Rows[0]["LoginId"].ToString();
                    pnlMain.Attributes.Add("style", "display:block;"); ;
                   
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




        protected void BtnUpdate_Click(object sender, EventArgs e)
        {

            try
            {

                //string Qty= "Select * from tbl_passwordpolicy where userid='" + dt_login_details.Rows[0]["Userid"].ToString() + "'";
                //DataTable dt = new DataTable();
                //dt = CommonFunctions.fetchdata(Qty);

                //if (dt.Rows.Count > 0)
                //{
                //    if (CommonFunctions.base64Decode(dt.Rows[0]["old_password"].ToString().Trim()).Trim() == txtNewPassword.Text.ToString().Trim())
                //    {
                //        txtNewPassword.Text = "";
                //        txtConfirmpassword.Text = "";
                //        Response.Write("<script>alert('You have already setup this password one time. Please try a new password.')</script>");
                //        return;
                //    }
                //}

                //------Update New Password-----------------


                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "UspUserMasterChangePassword";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@LoginId", dt_login_details.Rows[0]["LoginId"].ToString());
                cmd.Parameters.AddWithValue("@Password", CommonFunctions.base64Encode(txtOldPassword.Text.ToString().Trim()) );
                cmd.Parameters.AddWithValue("@NewPassword", CommonFunctions.base64Encode(txtConfirmpassword.Text.ToString().Trim()) );               
                SqlParameter output = new SqlParameter("@SuccessId", SqlDbType.Int);
                output.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(output);
                con.Open();
                cmd.ExecuteNonQuery();
                String R = output.Value.ToString();
                con.Close();


                if (R != String.Empty)
                {
                    //-------------Audit Details -------------------
                    //lblloginmsg.Visible = true;
                    //lblloginmsg.CssClass = "successmsg";
                    //lblloginmsg.Text = "Password Updated Sucessfully";
                    //Response.Write("<script>alert(Password Updated sucessfully. Please login again with the new password.)</script>");
                    //Session.Abandon();
                    Session["LoginDetails"] = null;
                    pnlMain.Attributes.Add("style", "display:none;"); ;
                    if (Session["LoginDetails"] == null)
                    {

                        pnlmsg.Attributes.Add("style", "display:block;"); ;

                        //lblloginmsg.Visible = true;
                        //lblloginmsg.Attributes.Add("class", "active");
                        //lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                        //lblloginmsg.Text = " <strong>Warning!</strong> <h4 >" + " Password Updated sucessfully. Your current sesson will be terminated. Please login again with the new password.!" + " </h4>";

                        //Response.Write("<script>alert(Password Updated sucessfully. Your current sesson will be terminated. Please login again with the new password. )</script>");
                        Session.Abandon();
                       // Server.Transfer("Login.aspx", false);
                    }

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

        protected void btn_Click(object sender, EventArgs e)
        {
            Server.Transfer("Login.aspx", false);
        }
    }
}