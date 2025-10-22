# 函数：proxy_toggle
# 功能：切换（开启/关闭）终端代理
function proxy_toggle
    # 检查 https_proxy 变量是否已设置
    if set -q https_proxy
        # 如果已设置，则清除所有代理变量
        set -e https_proxy
        set -e http_proxy
        set -e all_proxy
        echo -e "Proxy is \033[31mOFF\033[0m"
    else
        # 如果未设置，则设置代理
        set -x https_proxy "http://127.0.0.1:7890"
        set -x http_proxy "http://127.0.0.1:7890"
        set -x all_proxy "http://127.0.0.1:7890"
        echo -e "Proxy is \033[32mON\033[0m (http://127.0.0.1:7890)"
    end
end
