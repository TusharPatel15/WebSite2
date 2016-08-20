<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Insert.aspx.cs" Inherits="CS" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type = "text/css">
        body
        {
            font-family:Arial;
            font-size:10pt;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    
    
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <b>First Name:</b>
            </td>
            <td>
                <asp:TextBox ID="txtFName" runat="server" Text="" />
            </td>
        </tr>
        <tr>
            <td>
                Last Name:
            </td>
            <td>
                <asp:TextBox ID="txtLName" runat="server" Text="" />
            </td>
        </tr>
        <tr>
            <td>
                City:
            </td>
            <td>
                <asp:TextBox ID="txtCity" runat="server" Text="" />
            </td>
        </tr>
        <tr>
            <td>
                Email ID:
            </td>
            <td>
                <asp:TextBox ID="txtEmail" runat="server" Text="" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="btnSave" Text="Save" runat="server" />
            </td>
        </tr>
    </table>
    <hr />
   

     <asp:GridView ID="gvUsers" runat="server"/>
     
   <%-- <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="false" 
        EnableModelValidation="True">
        <Columns>
            <asp:BoundField DataField="FirstName" HeaderText="First Name" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" />
            <asp:BoundField DataField="City" HeaderText="City" />
            <asp:BoundField DataField="EmailID" HeaderText="Email" />
        </Columns>
    </asp:GridView>--%>
    </form>
    
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript" src="http://cdn.jsdelivr.net/json2/0.1/json2.js"></script>
<script type="text/javascript">
    $(function () {
        $("[id*=btnSave]").bind("click", function () {
            var user = {};
            debugger;
            user.FirstName = $("[id*=txtFName]").val();
            user.LastName = $("[id*=txtLName]").val();
            user.City = $("[id*=txtCity]").val();
            user.EmailID = $("[id*=txtEmail]").val();
            $.ajax({
                type: "POST",
                url: "Insert.aspx/SaveUser",
                data: '{user: ' + JSON.stringify(user) + '}',
                //data: "{'FirstName': '" + FirstName + "','LastName': '" + LastName + "','City': '" + City + "','EmailID': '" + EmailID + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    alert("User has been added successfully.");
                    window.location.reload();
                }
            });
            return false;
        });
    });
</script>

<script type="text/javascript">
    $(document).ready(function () {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "Insert.aspx/BindDatatable",
            data: "{}",
            dataType: "json",
            success: function (data) {
                for (var i = 0; i < data.d.length; i++) {
                    $("#gvUsers").append("<tr><td>" + data.d[i].FirstName + "</td><td>" + data.d[i].LastName + "</td><td>" + data.d[i].City + "</td><td>" + data.d[i].EmailID + "</td></tr>");
                }
            },
            error: function (result) {
                alert("Error");
            }
        });
    });
</script>
</body>
</html>
