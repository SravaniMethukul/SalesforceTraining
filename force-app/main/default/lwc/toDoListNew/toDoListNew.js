import { LightningElement, track } from 'lwc';

export default class ToDoListNew extends LightningElement {
    taskadded = '';
    @track todoList = [];
    arraySize;
    initialtaskId = 1;
    //taskI

    handleInputToAdd(event) {
        try {
            this.taskadded = event.target.value;
            console.log("task to add: ", this.taskadded);
        }
        catch (error) {
            console.error('Handle Input:', error.message);
        }
    }

    get length() {
        return this.todoList.length;
    }

    handleOnAdd() {
        try {
            let taskIdToAssign = 0;
            const task = this.taskadded;
            if (!task) {
                console.error('Task is empty.');
                return;
            }
            //declare length variable
            if (this.length === 0) {
                taskIdToAssign = this.initialtaskId;
            }
            else {
                taskIdToAssign = this.length + 1;
            }
            const newtask = { id: taskIdToAssign, name: task };
            this.todoList = [...this.todoList, newtask];
            console.log("To-do list: ", this.todoList);
            this.taskadded = '';
            this.arraySize = this.length;
            this.todoList.forEach(x => {
                console.log("Employee Added", x.id);
                console.log("Employee Added", x.name);
            });
        }
        catch (error) {
            console.error('Handle Onclick:', error.message);
        }
    }

    handleRemove(event) {
        try {
            const taskId = parseInt(event.target.name || event.currentTarget.name, 10);
            console.log(event.target.name)
            console.log(event.currentTarget.name)
            //console the target 
            console.log('taskId:', taskId);

            //splice to remove element 
            this.todoList.splice(taskId - 1, 1);
            this.todoList.forEach((ele, index) => {
                ele.id = index + 1;
            });

            this.todoList.forEach(x => {
                console.log("Employees after removed: ", x.id);
                console.log("Employees after removed: ", x.name);
            });
            this.arraySize = this.length;
        }
        catch (error) {
            console.error('Handle Ondelete:', error.message);
        }
    }

    handleClear() {
        this.taskadded = '';
    }
}
