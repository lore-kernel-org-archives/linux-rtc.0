Return-Path: <ddaney.cavm@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180228151701.GM1479@piout.net>
References: <20180222200432.22003-1-david.daney@cavium.com> <20180228151701.GM1479@piout.net>
From: David Daney <ddaney.cavm@gmail.com>
Date: Fri, 2 Mar 2018 08:22:22 -0800
Message-ID: <CAKjEs9FbNDKNs5j-aZAmHCYO1YE5g70vLyuk1hGDNvvRWj977w@mail.gmail.com>
Subject: Re: [PATCH v6] rtc: isl12026: Add driver.
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: David Daney <david.daney@cavium.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: multipart/alternative; boundary="001a114b04a89b6f5d056670615e"
List-ID: <linux-rtc.vger.kernel.org>

--001a114b04a89b6f5d056670615e
Content-Type: text/plain; charset="UTF-8"

I am no longer able to test this patch as I lost access to the hardware.

If someone else wants to take charge of the patch, that would be great.

Sorry I couldn't drive this to completion,
David Daney

On Wed, Feb 28, 2018 at 7:17 AM, Alexandre Belloni <
alexandre.belloni@free-electrons.com> wrote:

> Hi,
>
> That's mostly good
>
> On 22/02/2018 at 12:04:32 -0800, David Daney wrote:
> > +     priv->rtc->ops = &isl12026_rtc_ops;
> > +     priv->rtc->nvram_old_abi = false;
>
> This allocation is not necessary and I would refer not having t so when
> the ABI goes away, it is not necessary to change this driver.
>
> > +     ret = rtc_register_device(priv->rtc);
> > +     if (ret)
> > +             return ret;
> > +
> > +     memset(&nvm_cfg, 0, sizeof(nvm_cfg));
> > +     nvm_cfg.name = "eeprom";
>
> You probably need something more descriptive, usually the rtc model name
> else, it is difficult (but not impossible) to find where this nvmem is
> actually located when using /sys/bus/nvmem/devices
> isl12026- would be a good choice.
>
> > +     nvm_cfg.read_only = false;
> > +     nvm_cfg.root_only = true;
>
> any reason to have it root only?
>
> > +     nvm_cfg.base_dev = &client->dev;
> > +     nvm_cfg.priv = priv;
> > +     nvm_cfg.stride = 1;
> > +     nvm_cfg.word_size = 1;
> > +     nvm_cfg.size = 512;
> > +     nvm_cfg.reg_read = isl12026_nvm_read;
> > +     nvm_cfg.reg_write = isl12026_nvm_write;
> > +
> > +     return rtc_nvmem_register(priv->rtc, &nvm_cfg);
>
> The probe function must not fail after rtc_register_device has been
> called so you must return 0 here.
>
> It is not currently possible to call rtc_nvmem_register before
> rtc_register_device unless we move the nvmem to the parent device:
>
> diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
> index 3a02357eb783..17ec4c8d0fad 100644
> --- a/drivers/rtc/nvmem.c
> +++ b/drivers/rtc/nvmem.c
> @@ -91,7 +91,7 @@ int rtc_nvmem_register(struct rtc_device *rtc,
>         if (!nvmem_config)
>                 return -ENODEV;
>
> -       nvmem_config->dev = &rtc->dev;
> +       nvmem_config->dev = rtc->dev.parent;
>         nvmem_config->owner = rtc->owner;
>         rtc->nvmem = nvmem_register(nvmem_config);
>         if (IS_ERR_OR_NULL(rtc->nvmem))
>
> I'll submit this patch for this cycle before there are many users of the
> interface (converted drivers are still exposing the old ABI).
>
> If you prefer, you can depend on it.
>
> --
> Alexandre Belloni, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--001a114b04a89b6f5d056670615e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am no longer able to test this patch as I lost access to=
 the hardware.<div><br></div><div>If someone else wants to take charge of t=
he patch, that would be great.</div><div><br></div><div>Sorry I couldn&#39;=
t drive this to completion,</div><div>David Daney</div></div><div class=3D"=
gmail_extra"><br><div class=3D"gmail_quote">On Wed, Feb 28, 2018 at 7:17 AM=
, Alexandre Belloni <span dir=3D"ltr">&lt;<a href=3D"mailto:alexandre.bello=
ni@free-electrons.com" target=3D"_blank">alexandre.belloni@free-electrons.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
That&#39;s mostly good<br>
<span class=3D""><br>
On 22/02/2018 at 12:04:32 -0800, David Daney wrote:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0priv-&gt;rtc-&gt;ops =3D &amp;isl12026_rtc_ops;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0priv-&gt;rtc-&gt;nvram_old_abi =3D false;<br>
<br>
</span>This allocation is not necessary and I would refer not having t so w=
hen<br>
the ABI goes away, it is not necessary to change this driver.<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D rtc_register_device(priv-&gt;rtc)<wbr>;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0memset(&amp;nvm_cfg, 0, sizeof(nvm_cfg));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0<a href=3D"http://nvm_cfg.name" rel=3D"noreferrer=
" target=3D"_blank">nvm_cfg.name</a> =3D &quot;eeprom&quot;;<br>
<br>
</span>You probably need something more descriptive, usually the rtc model =
name<br>
else, it is difficult (but not impossible) to find where this nvmem is<br>
actually located when using /sys/bus/nvmem/devices<br>
isl12026- would be a good choice.<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0nvm_cfg.read_only =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0nvm_cfg.root_only =3D true;<br>
<br>
</span>any reason to have it root only?<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0nvm_cfg.base_dev =3D &amp;client-&gt;dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0nvm_cfg.priv =3D priv;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0nvm_cfg.stride =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0nvm_cfg.word_size =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0nvm_cfg.size =3D 512;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0nvm_cfg.reg_read =3D isl12026_nvm_read;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0nvm_cfg.reg_write =3D isl12026_nvm_write;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return rtc_nvmem_register(priv-&gt;rtc, &amp;nvm_=
cfg);<br>
<br>
</span>The probe function must not fail after rtc_register_device has been<=
br>
called so you must return 0 here.<br>
<br>
It is not currently possible to call rtc_nvmem_register before<br>
rtc_register_device unless we move the nvmem to the parent device:<br>
<br>
diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c<br>
index 3a02357eb783..17ec4c8d0fad 100644<br>
--- a/drivers/rtc/nvmem.c<br>
+++ b/drivers/rtc/nvmem.c<br>
@@ -91,7 +91,7 @@ int rtc_nvmem_register(struct rtc_device *rtc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!nvmem_config)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0nvmem_config-&gt;dev =3D &amp;rtc-&gt;dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0nvmem_config-&gt;dev =3D rtc-&gt;dev.parent;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 nvmem_config-&gt;owner =3D rtc-&gt;owner;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rtc-&gt;nvmem =3D nvmem_register(nvmem_config);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR_OR_NULL(rtc-&gt;nvmem))<br>
<br>
I&#39;ll submit this patch for this cycle before there are many users of th=
e<br>
interface (converted drivers are still exposing the old ABI).<br>
<br>
If you prefer, you can depend on it.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Alexandre Belloni, Bootlin (formerly Free Electrons)<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" rel=3D"noreferrer" target=3D"_blank">https:=
//bootlin.com</a><br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5">--<br>
To unsubscribe from this list: send the line &quot;unsubscribe devicetree&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<wbr>m=
ajordomo-info.html</a><br>
</div></div></blockquote></div><br></div>

--001a114b04a89b6f5d056670615e--
