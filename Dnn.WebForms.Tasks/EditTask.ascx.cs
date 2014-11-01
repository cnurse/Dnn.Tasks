/*
The MIT License (MIT)

Copyright (c) 2014 Charles Nurse

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */
using System;
using Dnn.WebForms.Tasks.Components;
using DotNetNuke.Collections;
using DotNetNuke.Common;
using DotNetNuke.UI.Modules;

namespace Dnn.WebForms.Tasks
{
    public partial class EditTask : ModuleUserControlBase
    {
        private int taskId;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            saveTask.Click += saveTask_Click;
        }

        protected override void OnLoad(EventArgs e)
        {
            taskId = Request.QueryString.GetValueOrDefault<int>("TaskId", -1);

            if (!IsPostBack && taskId > -1)
            {
                var task = TaskController.Instance.GetTask(taskId);
                taskName.Text = task.Name;
                taskDescription.Text = task.Description;
                isComplete.Checked = task.IsComplete;
            }
        }

        void saveTask_Click(object sender, EventArgs e)
        {
            var task = new Task
                            {
                                ModuleID = ModuleContext.ModuleId,
                                Name = taskName.Text,
                                Description = taskDescription.Text,
                                IsComplete = isComplete.Checked
                            };

            if (taskId > -1)
            {
                task.TaskID = taskId;
                TaskController.Instance.UpdateTask(task);
            }
            else
            {
                TaskController.Instance.AddTask(task);
            }

            Response.Redirect(Globals.NavigateURL());
        }
    }
}