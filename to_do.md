测试环境中，脚本执行后强行注入本地hosts，但是会带来诸多不便（比如监听了非标准443端口，而cdn又配置了回源端口转发），
因此应该删除自定义强行绑定的hosts
```
nano /etc/hosts
ping example.com # 进行验证
```

在标准的 DNS 规范（RFC 1035）中，域名标签（Label）是不允许使用下划线的。你的正则严格执行了这一点，因此直接被拒绝。

[emerg] 1021020#1021020: could not build server_names_hash, you should increase server_names_hash_bucket_size: 64 是啥意思

nano /etc/nginx/nginx.conf

# 关键修改：增大哈希桶大小，通常 128 足够应付绝大多数长域名
    server_names_hash_bucket_size 128;

Error: $table_prefix in wp-config.php can only contain numbers, letters, and underscores.
代码里这部分也要修改一下，防止域名标签含有连字符

申请的证书只是给1级申请的
