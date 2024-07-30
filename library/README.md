# await-to-arkts

> 基于 [await-to-js] 原库3.0.0版本进行适配，使其可以运行在 OpenHarmony，并沿用其现有用法和特性。
>
> Async await wrapper for easy error handling

## Install

```sh
ohpm install await-to-arkts
```

## ArkTs usage

```typescript
import to from 'await-to-arkts';

interface ServerResponse {
test: string;
}

const p = Promise.resolve(new Object({ test: '123' }) as ServerResponse);

const result = await to<ServerResponse>(p);

const err = result[0];
const data = result[1];

if (err) {
  // error case, do something
}

// success case, do something
console.log(data?.test);
```

## 参与贡献

1. Fork 本仓库
2. 新建 Feat_xxx 分支
3. 提交代码
4. 新建 Pull Request

## License

MIT © [郭佳兵](https://gitee.com/guojiabing)

[await-to-js]: https://npmjs.org/package/await-to-js
