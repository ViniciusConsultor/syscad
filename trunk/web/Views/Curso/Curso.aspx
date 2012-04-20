<%@ Page Language="C#"  Inherits="System.Web.Mvc.ViewPage<DataTable>" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Xml.Xsl" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Linq" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
  



    protected void Store1_Submit(object sender, StoreSubmitDataEventArgs e)
    {
        string format = this.FormatType.Value.ToString();

        XmlNode xml = e.Xml;

        this.Response.Clear();

        switch (format)
        {
            case "xml":
                string strXml = xml.OuterXml;
                this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.xml");
                this.Response.AddHeader("Content-Length", strXml.Length.ToString());
                this.Response.ContentType = "application/xml";
                this.Response.Write(strXml);

                break;
            case "xls":
                this.Response.ContentType = "application/vnd.ms-excel";
                this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.xls");
                XslCompiledTransform xtExcel = new XslCompiledTransform();
                xtExcel.Load(Server.MapPath("Excel.xsl"));
                xtExcel.Transform(xml, null, Response.OutputStream);

                break;
            case "csv":
                this.Response.ContentType = "application/octet-stream";
                this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.csv");
                XslCompiledTransform xtCsv = new XslCompiledTransform();
                xtCsv.Load(Server.MapPath("Csv.xsl"));
                xtCsv.Transform(xml, null, Response.OutputStream);

                break;
        }

        this.Response.End();
    }
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>GridPanel using DataTable with Paging and Remote Reloading - Ext.NET Examples</title>

    <script type="text/javascript">
        var template = '<span style="color:{0};">{1}</span>';

        var change = function (value) {
            return String.format(template, (value > 0) ? "green" : "red", value);
        };

        var pctChange = function (value) {
            return String.format(template, (value > 0) ? "green" : "red", value + "%");
        };

        var exportData = function (format) {
            FormatType.setValue(format);
            var store = GridPanel1.getStore();
            store.directEventConfig.isUpload = true;

            var records = store.reader.readRecords(store.proxy.data).records,
                values = [];

            for (i = 0; i < records.length; i++) {
                var obj = {}, dataR;

                if (store.reader.meta.id) {
                    obj[store.reader.meta.id] = records[i].id;
                }

                dataR = Ext.apply(obj, records[i].data);

                if (!Ext.isEmptyObj(dataR)) {
                    values.push(dataR);
                }
            }

            store.submitData(values);

            store.directEventConfig.isUpload = false;
        };
    </script>
</head>
<body>
    <form id="Form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        
        <ext:Hidden ID="FormatType" runat="server" />

        <ext:GridPanel 
            ID="GridPanel1"
            runat="server" 
            Title="DataTable Grid" 
            Width="600" 
            Height="320"
            >
            <Store>
                <ext:Store 
                    ID="Store1" 
                    runat="server">
                    <Proxy>
                        <ext:HttpProxy Json="true" Method="GET" Url="/Curso/FindAll" AutoDataBind="true" />
                    </Proxy>
                    <Reader>
                        <ext:JsonReader Root="cursos" TotalProperty="totalReg">
                            <Fields>
                                <ext:RecordField Name="nome" Type="String" />
                                <ext:RecordField Name="descricao" Type="String" />
                                <ext:RecordField Name="valor" Type="Float" />
                            </Fields>
                        </ext:JsonReader>
                    </Reader>
                </ext:Store>
            </Store>
            <ColumnModel ID="ColumnModel1" runat="server">
                <Columns>
                    <ext:Column ColumnID="nome" Header="Nome" DataIndex="nome">
                        <Editor>
                            <ext:TextField ID="TextField1" runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column ColumnID="descricao" Header="Descrição" DataIndex="descricao">
                        <Editor>
                            <ext:TextField ID="TextField3" runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column Header="Valor" Width="75" DataIndex="valor">
                        <Renderer Format="UsMoney" />
                        <Editor>
                            <ext:TextField ID="TextField2" runat="server" />
                        </Editor>
                    </ext:Column>
                    
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" />
            </SelectionModel>
            <LoadMask ShowMask="true" />
            <TopBar>
                <ext:Toolbar ID="Toolbar1" runat="server">
                    <Items>
                        <ext:ToolbarFill ID="ToolbarFill1" runat="server" />
                        <ext:Button ID="Button1" runat="server" Text="To XML" Icon="PageCode">
                            <Listeners>
                                <Click Handler="exportData('xml');" />
                            </Listeners>
                        </ext:Button>
                        
                        <ext:Button ID="Button2" runat="server" Text="To Excel" Icon="PageExcel">
                            <Listeners>
                                <Click Handler="exportData('xls');" />
                            </Listeners>
                        </ext:Button>
                        
                        <ext:Button ID="Button3" runat="server" Text="To CSV" Icon="PageAttach">
                            <Listeners>
                                <Click Handler="exportData('csv');" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <BottomBar>
                <ext:PagingToolbar ID="PagingToolbar1" runat="server" PageSize="10" />
            </BottomBar>
        </ext:GridPanel>
    </form>
</body>
</html>