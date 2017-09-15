Date: Sat, 16 Sep 2017 01:21:34 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: ying.zhang22455@nxp.com
Cc: rtc-linux@googlegroups.com, jiafei.pan@nxp.com
Subject: Re: [rtc-linux] [PATCH] drivers/rtc/rtc-pcf85263.c: add support for
 devicetree
Message-ID: <20170915232134.7nq34do64aqlprye@piout.net>
References: <20170906054403.18567-1-ying.zhang22455@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170906054403.18567-1-ying.zhang22455@nxp.com>
List-ID: <rtc-linux.googlegroups.com>

Hi,

This email was not send to the correct mailing list.

On 06/09/2017 at 13:44:03 +0800, ying.zhang22455@nxp.com wrote:
> From: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> 
> Add compatible string "nxp,rtc-pcf85263"

It doesn't add the compatible string anywhere.

> Document the binding
> 
> Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> ---
>  Documentation/devicetree/bindings/rtc/nxp,rtc-85263.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/nxp,rtc-85263.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,rtc-85263.txt b/Documentation/devicetree/bindings/rtc/nxp,rtc-85263.txt
> new file mode 100644
> index 000000000000..d2ffd3626f5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nxp,rtc-85263.txt
> @@ -0,0 +1,15 @@
> +NXP PCF85263 SPI Real Time Clock
> +
> +Required properties:
> +- compatible: should be: "nxp,rtc-pcf85263"

The proper compatible string would be "nxp,pcf85263"

Also, please have a look at
http://patchwork.ozlabs.org/patch/658956/
http://patchwork.ozlabs.org/patch/658957/

Martin never replied but you can probably push them again.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
