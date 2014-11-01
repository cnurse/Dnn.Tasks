#region Copyright
// 
// DotNetNuke® - http://www.dotnetnuke.com
// Copyright (c) 2002-2012
// by DotNetNuke Corporation
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
// documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and 
// to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all copies or substantial portions 
// of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
// TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
// DEALINGS IN THE SOFTWARE.
#endregion

using System;
using System.Linq;
using System.Web.UI.WebControls;
using Dnn.WebForms.Tasks.Components;
using DotNetNuke.Services.Localization;
using DotNetNuke.UI.Modules;

namespace Dnn.WebForms.Tasks
{
    public partial class Tasks : ModuleUserControlBase
    {
        protected string LocalizeSafeJsString(string key)
        {
            return Localization.GetSafeJSString(key, LocalResourceFile);
        }

        private void BindGrid()
        {
            tasks.DataSource = TaskController.Instance.GetTasks(ModuleContext.ModuleId);
            tasks.DataBind();
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            tasks.ItemDataBound += tasks_ItemDataBound;
            tasks.ItemCommand += tasks_ItemCommand;
            addTask.NavigateUrl = ModuleContext.EditUrl("Edit");
        }

        void tasks_ItemCommand(object source, DataGridCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                var task = TaskController.Instance.GetTasks(ModuleContext.ModuleId).ToList()[e.Item.ItemIndex];

                if (task != null)
                {
                    TaskController.Instance.DeleteTask(task);
                    BindGrid();
                }
            }
        }

        void tasks_ItemDataBound(object sender, DataGridItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                var task = e.Item.DataItem as Task;

                if (task != null)
                {
                    var editLink = e.Item.Cells[3].Controls[1] as HyperLink;
                    if (editLink != null)
                    {
                        editLink.NavigateUrl = ModuleContext.EditUrl("TaskId", task.TaskID.ToString(), "Edit");
                    }
                }
            }
        }

        protected override void OnLoad(EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }
    }
}