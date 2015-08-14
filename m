Return-Path: <rtc-linux+bncBDYN53XCUYHBBMUIXCXAKGQEXITBLHA@googlegroups.com>
Date: Fri, 14 Aug 2015 08:07:28 -0700 (PDT)
From: suneelgarapati@gmail.com
To: rtc-linux <rtc-linux@googlegroups.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	alexandre.belloni@free-electrons.com, michals@xilinx.com,
	sorenb@xilinx.com, a.zummo@towertech.it, suneel.garapati@xilinx.com
Message-Id: <9aef2bb6-2df6-4578-b186-43ad411cc41e@googlegroups.com>
In-Reply-To: <1439564462-21252-1-git-send-email-suneel.garapati@xilinx.com>
References: <1439564462-21252-1-git-send-email-suneel.garapati@xilinx.com>
Subject: [rtc-linux] Re: [PATCH v3 1/3] devicetree: bindings: rtc: add
 bindings for xilinx zynqmp rtc
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_864_2014497434.1439564848799"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

------=_Part_864_2014497434.1439564848799
Content-Type: multipart/alternative;
	boundary="----=_Part_865_907421760.1439564848799"

------=_Part_865_907421760.1439564848799
Content-Type: text/plain; charset=UTF-8

Wrongly sent as 3-patch series, will send again.

Suneel

On Friday, August 14, 2015 at 8:31:20 PM UTC+5:30, Suneel Garapati wrote:
>
> adds file for description on device node bindings for RTC 
> found on Xilinx Zynq Ultrascale+ MPSoC. 
>
> Signed-off-by: Suneel Garapati <suneel....@xilinx.com <javascript:>> 
> --- 
> Changes v3 
> - none 
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

------=_Part_865_907421760.1439564848799
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Wrongly sent as 3-patch series, will send again.<div><br><=
/div><div>Suneel<br><br>On Friday, August 14, 2015 at 8:31:20 PM UTC+5:30, =
Suneel Garapati wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;=
margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">adds fil=
e for description on device node bindings for RTC
<br>found on Xilinx Zynq Ultrascale+ MPSoC.
<br>
<br>Signed-off-by: Suneel Garapati &lt;<a href=3D"javascript:" target=3D"_b=
lank" gdf-obfuscated-mailto=3D"3_N7on52AwAJ" rel=3D"nofollow" onmousedown=
=3D"this.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.href=3D=
&#39;javascript:&#39;;return true;">suneel....@xilinx.com</a>&gt;
<br>---
<br>Changes v3
<br>- none
<br>Changes v2=20
<br>- add examples for interrupt-names=20
<br>- change alm to alarm=20
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
<br>--=20
<br>2.1.2
<br>
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

------=_Part_865_907421760.1439564848799--

------=_Part_864_2014497434.1439564848799--
