import { to } from 'await-to-arkts';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  async aboutToAppear() {
    const success = Promise.resolve("it is success!")
    const fail = Promise.reject(new Error("oh, my god~"))

    const result = await to(fail, new Object({ errorCode: 1, errorMessage: '自定义的错误信息！' }));

    const error = result[0];
    const data = result[1];

    console.log('失败的案例 =====> ', JSON.stringify(error), data)

    const result1 = await to(success);

    console.log('成功的案例 -----> ', JSON.stringify(result1[0]), result1[1])
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
    }
    .height('100%')
    .width('100%')
  }
}