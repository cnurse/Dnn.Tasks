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