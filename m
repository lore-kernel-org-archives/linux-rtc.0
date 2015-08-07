Return-Path: <rtc-linux+bncBDYN53XCUYHBBNXTSCXAKGQEOGSXNPI@googlegroups.com>
Date: Thu, 6 Aug 2015 21:53:09 -0700 (PDT)
From: suneelgarapati@gmail.com
To: rtc-linux <rtc-linux@googlegroups.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	michals@xilinx.com, sorenb@xilinx.com, a.zummo@towertech.it,
	suneel.garapati@xilinx.com, anirudh@xilinx.com
Message-Id: <7f57f610-7eea-434c-b7b8-3fb15cea18c0@googlegroups.com>
In-Reply-To: <1438336757-23404-1-git-send-email-suneel.garapati@xilinx.com>
References: <1438336757-23404-1-git-send-email-suneel.garapati@xilinx.com>
Subject: [rtc-linux] Re: [PATCH v2 1/2] devicetree: bindings: rtc: add
 bindings for xilinx zynqmp rtc
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_1696_1072829008.1438923189305"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

------=_Part_1696_1072829008.1438923189305
Content-Type: multipart/alternative;
	boundary="----=_Part_1697_290737977.1438923189305"

------=_Part_1697_290737977.1438923189305
Content-Type: text/plain; charset=UTF-8

Hi Alexandre Belloni,

Any review comments on v2 series?

Regards,
Suneel

On Friday, July 31, 2015 at 3:29:36 PM UTC+5:30, Suneel Garapati wrote:
>
> adds file for description on device node bindings for RTC 
> found on Xilinx Zynq Ultrascale+ MPSoC. 
>
> Signed-off-by: Suneel Garapati <suneel....@xilinx.com <javascript:>> 
> --- 
> Changes v2 
> - add examples for interrupt-names 
> - change alm to alarm 
> --- 
>  Documentation/devicetree/bindings/rtc/xlnx-rtc.txt | 25 
> ++++++++++++++++++++++ 
>  1 file changed, 25 insertions(+) 
>  create mode 100644 Documentation/devicetree/bindings/rtc/xlnx-rtc.txt 
>
> diff --git a/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt 
> b/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt 
> new file mode 100644 
> index 0000000..0df6f01 
> --- /dev/null 
> +++ b/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt 
> @@ -0,0 +1,25 @@ 
> +* Xilinx Zynq Ultrascale+ MPSoC Real Time Clock 
> + 
> +RTC controller for the Xilinx Zynq MPSoC Real Time Clock 
> +Separate IRQ lines for seconds and alarm 
> + 
> +Required properties: 
> +- compatible: Should be "xlnx,zynqmp-rtc" 
> +- reg: Physical base address of the controller and length 
> +       of memory mapped region. 
> +- interrupts: IRQ lines for the RTC. 
> +- interrupt-names: interrupt line names eg. "sec" "alarm" 
> + 
> +Optional: 
> +- calibration: calibration value for 1 sec period which will 
> +                be programmed directly to calibration register 
> + 
> +Example: 
> +rtc: rtc@ffa60000 { 
> +        compatible = "xlnx,zynqmp-rtc"; 
> +        reg = <0x0 0xffa60000 0x100>; 
> +        interrupt-parent = <&gic>; 
> +        interrupts = <0 26 4>, <0 27 4>; 
> +        interrupt-names = "alarm", "sec"; 
> +        calibration = <0x198233>; 
> +}; 
> -- 
> 2.1.2 
>

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

------=_Part_1697_290737977.1438923189305
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alexandre Belloni,<div><br></div><div>Any review commen=
ts on v2 series?</div><div><br></div><div>Regards,</div><div>Suneel</div><d=
iv><br>On Friday, July 31, 2015 at 3:29:36 PM UTC+5:30, Suneel Garapati wro=
te:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;=
border-left: 1px #ccc solid;padding-left: 1ex;">adds file for description o=
n device node bindings for RTC
<br>found on Xilinx Zynq Ultrascale+ MPSoC.
<br>
<br>Signed-off-by: Suneel Garapati &lt;<a href=3D"javascript:" target=3D"_b=
lank" gdf-obfuscated-mailto=3D"LWAsUAuGBAAJ" rel=3D"nofollow" onmousedown=
=3D"this.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.href=3D=
&#39;javascript:&#39;;return true;">suneel....@xilinx.com</a>&gt;
<br>---
<br>Changes v2
<br>- add examples for interrupt-names
<br>- change alm to alarm
<br>---
<br>=C2=A0Documentation/devicetree/<wbr>bindings/rtc/xlnx-rtc.txt | 25 ++++=
++++++++++++++++++
<br>=C2=A01 file changed, 25 insertions(+)
<br>=C2=A0create mode 100644 Documentation/devicetree/<wbr>bindings/rtc/xln=
x-rtc.txt
<br>
<br>diff --git a/Documentation/devicetree/<wbr>bindings/rtc/xlnx-rtc.txt b/=
Documentation/devicetree/<wbr>bindings/rtc/xlnx-rtc.txt
<br>new file mode 100644
<br>index 0000000..0df6f01
<br>--- /dev/null
<br>+++ b/Documentation/devicetree/<wbr>bindings/rtc/xlnx-rtc.txt
<br>@@ -0,0 +1,25 @@
<br>+* Xilinx Zynq Ultrascale+ MPSoC Real Time Clock
<br>+
<br>+RTC controller for the Xilinx Zynq MPSoC Real Time Clock
<br>+Separate IRQ lines for seconds and alarm
<br>+
<br>+Required properties:
<br>+- compatible: Should be &quot;xlnx,zynqmp-rtc&quot;
<br>+- reg: Physical base address of the controller and length
<br>+ =C2=A0 =C2=A0 =C2=A0 of memory mapped region.
<br>+- interrupts: IRQ lines for the RTC.
<br>+- interrupt-names: interrupt line names eg. &quot;sec&quot; &quot;alar=
m&quot;
<br>+
<br>+Optional:
<br>+- calibration: calibration value for 1 sec period which will
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0be programmed directly to calibration register
<br>+
<br>+Example:
<br>+rtc: rtc@ffa60000 {
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D &quot;x=
lnx,zynqmp-rtc&quot;;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg =3D &lt;0x0 0xffa6=
0000 0x100&gt;;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0interrupt-parent =3D &=
lt;&amp;gic&gt;;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0interrupts =3D &lt;0 2=
6 4&gt;, &lt;0 27 4&gt;;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0interrupt-names =3D &q=
uot;alarm&quot;, &quot;sec&quot;;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0calibration =3D &lt;0x=
198233&gt;;
<br>+};
<br>--
<br>2.1.2
<br></blockquote></div></div>

<p></p>

-- <br />
-- <br />
You received this message because you are subscribed to &quot;rtc-linux&quo=
t;.<br />
Membership options at <a href=3D"http://groups.google.com/group/rtc-linux">=
http://groups.google.com/group/rtc-linux</a> .<br />
Please read <a href=3D"http://groups.google.com/group/rtc-linux/web/checkli=
st">http://groups.google.com/group/rtc-linux/web/checklist</a><br />
before submitting a driver.<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;rtc-linux&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:rtc-linux+unsubscribe@googlegroups.com">rtc-linux=
+unsubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_1697_290737977.1438923189305--

------=_Part_1696_1072829008.1438923189305--
