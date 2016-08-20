<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Bind.aspx.cs" Inherits="Bind" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js">
    </script>

     <script type="text/javascript">
         $(document).ready(function () {
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "Bind.aspx/BindDatatable",
                 data: "{}",
                 dataType: "json",
                 success: function (data) {
                     for (var i = 0; i < data.d.length; i++) {
                         $("#gvDetails").append("<tr><td>" + data.d[i].FirstName + "</td><td>" + data.d[i].LastName + "</td><td>" + data.d[i].City + "</td><td>" + data.d[i].EmailID + "</td></tr>");
                     }
                 },
                 error: function (result) {
                     alert("Error");
                 }
             });
         });
</script>

 <style type="text/css">
table,th,td

border:1px solid black;
border-collapse:collapse;
}
</style>

</head>
<body>
    <form id="form1" runat="server">
    <div>
     <asp:GridView ID="gvDetails" runat="server" AutoGenerateColumns="false">
     </asp:GridView>
         <%--<table id="tbDetails" cellpadding="0" cellspacing="0">
            <thead style="background-color:#DC5807; color:White; font-weight:bold">
            <tr style="border:solid 1px #000000">
            <td>ID</td>
            <td>First Name</td>
            <td>Last Name</td>
            <td>City</td>
            <td>Email ID</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>--%>
    </div>
    </form>
</body>
</html>
