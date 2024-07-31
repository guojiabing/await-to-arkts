import { to } from 'await-to-arkts';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  async aboutToRecycle() {
    const success = Promise.resolve("it is success!")
    const fail = Promise.reject(new Error("oh, my god~"))

    const result = await to(fail, new Object({ errorCode: 1, errorMessage: '自定义的错误信息！' }));

    const error = result[0];
    const data = result[1];

    console.log('失败的案例 =====> ', JSON.stringify(error), data)

    const result1 = await to(success);

    console.log('成功的案例 -----> ', JSON.stringify(result1[0]), result1[1])
  }

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
        message: err.message
      });

      return;
    }

    // success case, do something
    console.log(`老人家高寿：${person?.age}`)
  }

  async aboutToDisappear() {
    interface ServerResponse {
      test: string;
    }

    const p = Promise.resolve(new Object({ test: '123' }) as ServerResponse);

    const result = await to<ServerResponse>(p);

    const err = result[0];
    const data = result[1];

    if (err) {
      // do something
    }

    console.log(data?.test);
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