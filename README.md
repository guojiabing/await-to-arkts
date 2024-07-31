# await-to-arkts

> 基于 [await-to-js] 原库3.0.0版本进行适配，使其可以运行在 OpenHarmony，并沿用其现有用法和特性。
>
> Async await wrapper for easy error handling

## Install

```sh
ohpm install await-to-arkts
```

## ArkTs usage

```extendtypescript
import { to } from 'await-to-arkts';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  async onClickHandler(_: ClickEvent) {
    const getLongLived = (): Promise<IPerson> => {
      return new Promise((resolve, reject) => {
        const age = Math.ceil(Math.random() * 200);
        const person = { name: 'zhang3', age, remark: '法外狂徒' } as IPerson;

        if (age < 100) {
          return reject(new Error('He is not a long-lived person!'));
        }

        resolve(person);
      })
    }

    const result = await to(getLongLived());
    const err = result[0];
    const person = result[1];

    if (err) {
      // 处理异常
      promptAction.showToast({
        message: err.message,
      });

      return;
    }

    // success case, do something
    console.log(`老人家高寿：${person?.age}`)
  }

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(this.onClickHandler)
    }
    .height('100%')
    .width('100%')
  }
}

interface IPerson {
  name: string;
  age: number;
  remark: string;
}
```

## 参与贡献

1. Fork 本仓库
2. 新建 Feat_xxx 分支
3. 提交代码
4. 新建 Pull Request

## License

MIT © [郭佳兵](https://gitee.com/guojiabing)

[await-to-js]: https://npmjs.org/package/await-to-js
