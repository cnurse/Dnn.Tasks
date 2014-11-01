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