Return-Path: <rtc-linux+bncBDYN53XCUYHBBTU35GWQKGQEOISEKRY@googlegroups.com>
Date: Thu, 30 Jul 2015 09:16:12 -0700 (PDT)
From: suneelgarapati@gmail.com
To: rtc-linux <rtc-linux@googlegroups.com>
Cc: suneel.garapati@xilinx.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, a.zummo@towertech.it,
	michals@xilinx.com, sorenb@xilinx.com, mark.rutland@arm.com
Message-Id: <3278813f-e7ac-4749-a040-25ba0508ab29@googlegroups.com>
In-Reply-To: <20150723115555.GC12330@leverpostej>
References: <1437648710-6857-1-git-send-email-suneel.garapati@xilinx.com>
 <20150723115555.GC12330@leverpostej>
Subject: [rtc-linux] Re: [PATCH 1/2] devicetree: bindings: rtc: add bindings
 for xilinx zynqmp rtc
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_7448_287527463.1438272973091"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

------=_Part_7448_287527463.1438272973091
Content-Type: multipart/alternative;
	boundary="----=_Part_7449_1352081459.1438272973092"

------=_Part_7449_1352081459.1438272973092
Content-Type: text/plain; charset=UTF-8

Hi Mark,

On Thursday, July 23, 2015 at 5:26:22 PM UTC+5:30, Mark Rutland wrote:
>
> On Thu, Jul 23, 2015 at 11:51:49AM +0100, Suneel Garapati wrote: 
> > adds file for description on device node bindings for RTC 
> > found on Xilinx Zynq Ultrascale+ MPSoC. 
> > 
> > Signed-off-by: Suneel Garapati <suneel....@xilinx.com <javascript:>> 
> > --- 
> >  Documentation/devicetree/bindings/rtc/xlnx-rtc.txt | 25 
> ++++++++++++++++++++++ 
> >  1 file changed, 25 insertions(+) 
> >  create mode 100644 Documentation/devicetree/bindings/rtc/xlnx-rtc.txt 
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt 
> b/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt 
> > new file mode 100644 
> > index 0000000..2b05243 
> > --- /dev/null 
> > +++ b/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt 
> > @@ -0,0 +1,25 @@ 
> > +* Xilinx Zynq Ultrascale+ MPSoC Real Time Clock 
> > + 
> > +RTC controller for the Xilinx Zynq MPSoC Real Time Clock 
> > +Separate IRQ lines for seconds and alarm 
> > + 
> > +Required properties: 
> > +- compatible: Should be "xlnx,zynqmp-rtc" 
> > +- reg: Physical base address of the controller and length 
> > +       of memory mapped region. 
> > +- interrupts: IRQ lines for the RTC. 
> > +- interrupt names: Names for interrupt lines 
>
> interrupt-names has a '-', and you need to state which names are 
> expected. 
>
> I will add the names and resend 

> > + 
> > +Optional: 
> > +- calibration: calibration value for 1 sec period which will 
> > +                be programmed directly to calibration register 
>
> When and why would I set this?

Crystal efficiency varies from board to board based on ppm, this effects 
the # ticks per sec and also temperature changes has an effect.
This is one way to configure calibration value of # ticks per sec through 
device tree, based on observations for a board.

Regards,
Suneel 


>
> Mark. 
>
> > + 
> > +Example: 
> > +rtc: rtc@ffa60000 { 
> > +        compatible = "xlnx,zynqmp-rtc"; 
> > +        reg = <0x0 0xffa60000 0x100>; 
> > +        interrupt-parent = <&gic>; 
> > +        interrupts = <0 26 4>, <0 27 4>; 
> > +        interrupt-names = "alm", "sec"; 
> > +        calibration = <0x198233>; 
> > +}; 
> > -- 
> > 2.1.2 
> > 
> > _______________________________________________ 
> > linux-arm-kernel mailing list 
> > linux-ar...@lists.infradead.org <javascript:> 
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel 
> > 
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

------=_Part_7449_1352081459.1438272973092
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Mark,<br><br>On Thursday, July 23, 2015 at 5:26:22 PM UTC+5:30, Mark Rut=
land wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left=
: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">On Thu, Jul 23, 201=
5 at 11:51:49AM +0100, Suneel Garapati wrote:
<br>&gt; adds file for description on device node bindings for RTC
<br>&gt; found on Xilinx Zynq Ultrascale+ MPSoC.
<br>&gt;=20
<br>&gt; Signed-off-by: Suneel Garapati &lt;<a href=3D"javascript:" target=
=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;javascript:&#3=
9;;return true;" onclick=3D"this.href=3D&#39;javascript:&#39;;return true;"=
>suneel....@xilinx.com</a>&gt;
<br>&gt; ---
<br>&gt; =C2=A0Documentation/devicetree/bindings/rtc/xlnx-rtc.txt | 25 ++++=
++++++++++++++++++
<br>&gt; =C2=A01 file changed, 25 insertions(+)
<br>&gt; =C2=A0create mode 100644 Documentation/devicetree/bindings/rtc/xln=
x-rtc.txt
<br>&gt;=20
<br>&gt; diff --git a/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt b/=
Documentation/devicetree/bindings/rtc/xlnx-rtc.txt
<br>&gt; new file mode 100644
<br>&gt; index 0000000..2b05243
<br>&gt; --- /dev/null
<br>&gt; +++ b/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt
<br>&gt; @@ -0,0 +1,25 @@
<br>&gt; +* Xilinx Zynq Ultrascale+ MPSoC Real Time Clock
<br>&gt; +
<br>&gt; +RTC controller for the Xilinx Zynq MPSoC Real Time Clock
<br>&gt; +Separate IRQ lines for seconds and alarm
<br>&gt; +
<br>&gt; +Required properties:
<br>&gt; +- compatible: Should be &quot;xlnx,zynqmp-rtc&quot;
<br>&gt; +- reg: Physical base address of the controller and length
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 of memory mapped region.
<br>&gt; +- interrupts: IRQ lines for the RTC.
<br>&gt; +- interrupt names: Names for interrupt lines
<br>
<br>interrupt-names has a &#39;-&#39;, and you need to state which names ar=
e
<br>expected.
<br>
<br></blockquote><div>I will add the names and resend=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: =
1px #ccc solid;padding-left: 1ex;">&gt; +
<br>&gt; +Optional:
<br>&gt; +- calibration: calibration value for 1 sec period which will
<br>&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0be programmed directly to calibration regi=
ster
<br>
<br>When and why would I set this?</blockquote><div>Crystal efficiency vari=
es from board to board based on ppm, this effects the # ticks per sec and a=
lso temperature changes has an effect.</div><div>This is one way to configu=
re calibration value of # ticks per sec through device tree, based on obser=
vations for a board.</div><div><br></div><div>Regards,</div><div>Suneel=C2=
=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin: =
0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">
<br>
<br>Mark.
<br>
<br>&gt; +
<br>&gt; +Example:
<br>&gt; +rtc: rtc@ffa60000 {
<br>&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D &q=
uot;xlnx,zynqmp-rtc&quot;;
<br>&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg =3D &lt;0x0 0=
xffa60000 0x100&gt;;
<br>&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0interrupt-parent =
=3D &lt;&amp;gic&gt;;
<br>&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0interrupts =3D &l=
t;0 26 4&gt;, &lt;0 27 4&gt;;
<br>&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0interrupt-names =
=3D &quot;alm&quot;, &quot;sec&quot;;
<br>&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0calibration =3D &=
lt;0x198233&gt;;
<br>&gt; +};
<br>&gt; --
<br>&gt; 2.1.2
<br>&gt;=20
<br>&gt; _______________________________________________
<br>&gt; linux-arm-kernel mailing list
<br>&gt; <a href=3D"javascript:" target=3D"_blank" rel=3D"nofollow" onmouse=
down=3D"this.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.hre=
f=3D&#39;javascript:&#39;;return true;">linux-ar...@lists.infradead.org</a>
<br>&gt; <a href=3D"http://lists.infradead.org/mailman/listinfo/linux-arm-k=
ernel" target=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;h=
ttp://www.google.com/url?q\75http%3A%2F%2Flists.infradead.org%2Fmailman%2Fl=
istinfo%2Flinux-arm-kernel\46sa\75D\46sntz\0751\46usg\75AFQjCNFVK8OeuW9xY29=
4bGsUtm4f-5lcRQ&#39;;return true;" onclick=3D"this.href=3D&#39;http://www.g=
oogle.com/url?q\75http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Fl=
inux-arm-kernel\46sa\75D\46sntz\0751\46usg\75AFQjCNFVK8OeuW9xY294bGsUtm4f-5=
lcRQ&#39;;return true;">http://lists.infradead.org/mailman/listinfo/linux-a=
rm-kernel</a>
<br>&gt;=20
<br></blockquote>

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

------=_Part_7449_1352081459.1438272973092--

------=_Part_7448_287527463.1438272973091--
