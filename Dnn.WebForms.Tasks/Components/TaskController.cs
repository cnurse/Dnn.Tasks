using System;
using System.Collections.Generic;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;
using DotNetNuke.Framework;

namespace Dnn.WebForms.Tasks.Components
{
    public class TaskController :  ServiceLocator<ITaskController, TaskController> , ITaskController
    {
        protected override Func<ITaskController> GetFactory()
        {
            return () => new TaskController();
        }

        public int AddTask(Task task)
        {
            return DataProvider.Instance().ExecuteScalar<int>("AddTask", task.ModuleID, task.Name, task.Description, task.IsComplete);
        }

        public void DeleteTask(Task task)
        {
            DataProvider.Instance().ExecuteNonQuery("DeleteTask", task.TaskID);
        }

        public Task GetTask(int taskId)
        {
            return CBO.FillObject<Task>(DataProvider.Instance().ExecuteReader("GetTask", taskId));
        }

        public IEnumerable<Task> GetTasks(int moduleId)
        {
            return CBO.FillCollection<Task>(DataProvider.Instance().ExecuteReader("GetTasks", moduleId));
        }

        public void UpdateTask(Task task)
        {
            DataProvider.Instance().ExecuteNonQuery("UpdateTask", task.TaskID, task.Name, task.Description, task.IsComplete);
        }
    }
}