# await-to-arkts

> 基于 [await-to-js] 原库3.0.0版本进行适配，使其可以运行在 OpenHarmony，并沿用其现有用法和特性。
> 
> Async await wrapper for easy error handling

## Install

```sh
ohpm install await-to-arkts --save
```

## Usage

```extendtypescript
import to from 'await-to-arkts';

async function asyncTaskWithCb(cb) {
  let err, user, savedTask, notification;

  [err, user] = await to(UserModel.findById(1));
  if (!user) return cb('No user found');

  [err, savedTask] = await to(TaskModel({ userId: user.id, name: 'Demo Task' }));
  if (err) return cb('Error occurred while saving task');

  if (user.notificationsEnabled) {
    [err] = await to(NotificationService.sendNotification(user.id, 'Task Created'));
    if (err) return cb('Error while sending notification');
  }

  if (savedTask.assignedUser.id !== user.id) {
    [err, notification] =
      await to(NotificationService.sendNotification(savedTask.assignedUser.id, 'Task was created for you'));
    if (err) return cb('Error while sending notification');
  }

  cb(null, savedTask);
}

async function asyncFunctionWithThrow() {
  const [err, user] = await to(UserModel.findById(1));

  if (!user) throw new Error('User not found');
}
```

## ArkTs usage

```extendtypescript
interface ServerResponse {
  test: number;
}

const p = Promise.resolve({ test: 123 });

const [err, data] = await to<ServerResponse>(p);
console.log(data.test);
```

## 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


## License

MIT © [郭佳兵](https://gitee.com/guojiabing)

[await-to-js]: https://npmjs.org/package/await-to-js
