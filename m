Return-Path: <rtc-linux+bncBDKY3XOCXMIBB6MZ2PIQKGQEF6VTJSQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com. [2607:f8b0:400d:c09::244])
        by gmr-mx.google.com with ESMTPS id k95si425421iod.0.2017.12.15.23.36.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Dec 2017 23:36:25 -0800 (PST)
Received: by mail-qk0-x244.google.com with SMTP id 8so13008167qkj.3
        for <rtc-linux@googlegroups.com>; Fri, 15 Dec 2017 23:36:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171216045542.GA52366@google.com>
References: <20171110215553.20696-2-enric.balletbo@collabora.com> <20171216045542.GA52366@google.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Sat, 16 Dec 2017 08:36:23 +0100
Message-ID: <CAFqH_529DtNycxTauXHAzmGKBvYXWNxFM9ouEZRB+JTD2eSyHA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v4 1/2] mfd: cros_ec: Introduce RTC commands
 and events definitions.
To: Brian Norris <briannorris@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Lee Jones <lee.jones@linaro.org>,
	bleung@chromium.org, Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, rtc-linux@googlegroups.com,
	Stephen Barber <smbarber@chromium.org>
Content-Type: multipart/alternative; boundary="001a114c8e6aa1a3680560702cf4"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--001a114c8e6aa1a3680560702cf4
Content-Type: text/plain; charset="UTF-8"

Brian,

El dia 16 des. 2017 05:58, "Brian Norris" <briannorris@chromium.org> va
escriure:

Hi,

On Fri, Nov 10, 2017 at 10:55:52PM +0100, Enric Balletbo i Serra wrote:
> From: Stephen Barber <smbarber@chromium.org>
>
> The EC can function as a simple RT, this patch adds the RTC related
> definitions needed by the rtc-cros-ec driver.
>
> Signed-off-by: Stephen Barber <smbarber@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Benson Leung <bleung@chromium.org>

Reviewed-by: Brian Norris <briannorris@chromium.org>

I guess this is waiting to get merged by an RTC maintainer, since it's a
dependency for the RTC driver in patch 2? Alessandro or Alexandre, any
thoughts?


Guess you missed the discussion in the cover letter of this patchset ;)
These patches has been accepted and merged soon for 4.16. Alexandre will do
it.

Thanks,
  Enric


Brian

> ---
>  include/linux/mfd/cros_ec_commands.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/linux/mfd/cros_ec_commands.h
b/include/linux/mfd/cros_ec_commands.h
> index 2b16e95..c6046a2 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -291,6 +291,9 @@ enum host_event_code {
>       /* EC desires to change state of host-controlled USB mux */
>       EC_HOST_EVENT_USB_MUX = 28,
>
> +     /* EC RTC event occurred */
> +     EC_HOST_EVENT_RTC = 26,
> +
>       /*
>        * The high bit of the event mask is not used as a host event
code.  If
>        * it reads back as set, then the entire event mask should be
> @@ -799,6 +802,8 @@ enum ec_feature_code {
>       EC_FEATURE_USB_MUX = 23,
>       /* Motion Sensor code has an internal software FIFO */
>       EC_FEATURE_MOTION_SENSE_FIFO = 24,
> +     /* EC has RTC feature that can be controlled by host commands */
> +     EC_FEATURE_RTC = 27,
>  };
>
>  #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
> @@ -1709,6 +1714,9 @@ struct ec_response_rtc {
>  #define EC_CMD_RTC_SET_VALUE 0x46
>  #define EC_CMD_RTC_SET_ALARM 0x47
>
> +/* Pass as param to SET_ALARM to clear the current alarm */
> +#define EC_RTC_ALARM_CLEAR 0
> +
>  /***********************************************************
******************/
>  /* Port80 log access */
>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--001a114c8e6aa1a3680560702cf4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Brian,<br><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">El dia 16 des. 2017 05:58, &quot;Brian Norris&quot; &lt;<a=
 href=3D"mailto:briannorris@chromium.org">briannorris@chromium.org</a>&gt; =
va escriure:<br type=3D"attribution"><blockquote class=3D"quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<div class=3D"quoted-text"><br>
On Fri, Nov 10, 2017 at 10:55:52PM +0100, Enric Balletbo i Serra wrote:<br>
&gt; From: Stephen Barber &lt;<a href=3D"mailto:smbarber@chromium.org">smba=
rber@chromium.org</a>&gt;<br>
&gt;<br>
&gt; The EC can function as a simple RT, this patch adds the RTC related<br=
>
&gt; definitions needed by the rtc-cros-ec driver.<br>
&gt;<br>
&gt; Signed-off-by: Stephen Barber &lt;<a href=3D"mailto:smbarber@chromium.=
org">smbarber@chromium.org</a>&gt;<br>
&gt; Signed-off-by: Enric Balletbo i Serra &lt;<a href=3D"mailto:enric.ball=
etbo@collabora.com">enric.balletbo@collabora.com</a>&gt;<br>
&gt; Acked-by: Lee Jones &lt;<a href=3D"mailto:lee.jones@linaro.org">lee.jo=
nes@linaro.org</a>&gt;<br>
&gt; Acked-by: Benson Leung &lt;<a href=3D"mailto:bleung@chromium.org">bleu=
ng@chromium.org</a>&gt;<br>
<br>
</div>Reviewed-by: Brian Norris &lt;<a href=3D"mailto:briannorris@chromium.=
org">briannorris@chromium.org</a>&gt;<br>
<br>
I guess this is waiting to get merged by an RTC maintainer, since it&#39;s =
a<br>
dependency for the RTC driver in patch 2? Alessandro or Alexandre, any<br>
thoughts?<br>
<font color=3D"#888888"></font></blockquote></div></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Guess you missed the discussion in the cov=
er letter of this patchset ;) These patches has been accepted and merged so=
on for 4.16. Alexandre will do it.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Thanks,</div><div dir=3D"auto">=C2=A0 Enric</div><div dir=3D"aut=
o"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=
=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><font color=3D"#888888"><br>
Brian<br>
</font><div class=3D"elided-text"><br>
&gt; ---<br>
&gt;=C2=A0 include/linux/mfd/cros_ec_<wbr>commands.h | 8 ++++++++<br>
&gt;=C2=A0 1 file changed, 8 insertions(+)<br>
&gt;<br>
&gt; diff --git a/include/linux/mfd/cros_ec_<wbr>commands.h b/include/linux=
/mfd/cros_ec_<wbr>commands.h<br>
&gt; index 2b16e95..c6046a2 100644<br>
&gt; --- a/include/linux/mfd/cros_ec_<wbr>commands.h<br>
&gt; +++ b/include/linux/mfd/cros_ec_<wbr>commands.h<br>
&gt; @@ -291,6 +291,9 @@ enum host_event_code {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* EC desires to change state of host-contro=
lled USB mux */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0EC_HOST_EVENT_USB_MUX =3D 28,<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* EC RTC event occurred */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0EC_HOST_EVENT_RTC =3D 26,<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The high bit of the event mask is not use=
d as a host event code.=C2=A0 If<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * it reads back as set, then the entire eve=
nt mask should be<br>
&gt; @@ -799,6 +802,8 @@ enum ec_feature_code {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0EC_FEATURE_USB_MUX =3D 23,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Motion Sensor code has an internal softwa=
re FIFO */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0EC_FEATURE_MOTION_SENSE_FIFO =3D 24,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* EC has RTC feature that can be controlled by h=
ost commands */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0EC_FEATURE_RTC =3D 27,<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 #define EC_FEATURE_MASK_0(event_code) (1UL &lt;&lt; (event_code =
% 32))<br>
&gt; @@ -1709,6 +1714,9 @@ struct ec_response_rtc {<br>
&gt;=C2=A0 #define EC_CMD_RTC_SET_VALUE 0x46<br>
&gt;=C2=A0 #define EC_CMD_RTC_SET_ALARM 0x47<br>
&gt;<br>
&gt; +/* Pass as param to SET_ALARM to clear the current alarm */<br>
&gt; +#define EC_RTC_ALARM_CLEAR 0<br>
&gt; +<br>
&gt;=C2=A0 /*****************************<wbr>*****************************=
*<wbr>******************/<br>
&gt;=C2=A0 /* Port80 log access */<br>
&gt;<br>
</div></blockquote></div><br></div></div></div>

<p></p>

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

--001a114c8e6aa1a3680560702cf4--
