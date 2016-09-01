Return-Path: <rtc-linux+bncBDTKFPPJUEHRB7FEUC7AKGQEYNYOLZY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22d.google.com (mail-wm0-x22d.google.com. [2a00:1450:400c:c09::22d])
        by gmr-mx.google.com with ESMTPS id e21si110200wmc.2.2016.09.01.04.35.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 04:35:24 -0700 (PDT)
Received: by mail-wm0-x22d.google.com with SMTP id w2so71675496wmd.0
        for <rtc-linux@googlegroups.com>; Thu, 01 Sep 2016 04:35:24 -0700 (PDT)
Date: Thu, 1 Sep 2016 13:35:22 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	kernel-janitors@vger.kernel.org, linux-tegra@vger.kernel.org,
	Alexandre Courbot <gnurou@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, Wan ZongShun <mcuos.com@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Eddie Huang <eddie.huang@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [rtc-linux] Re: [PATCH] rtc: constify rtc_class_ops structures
Message-ID: <20160901113522.GC18255@ulmo.ba.sec>
References: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
In-Reply-To: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Aug 31, 2016 at 10:05:25AM +0200, Julia Lawall wrote:
> Check for rtc_class_ops structures that are only passed to
> devm_rtc_device_register, rtc_device_register,
> platform_device_register_data, all of which declare the corresponding
> parameter as const.  Declare rtc_class_ops structures that have these
> properties as const.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct rtc_class_ops i@p = { ... };
> 
> @ok@
> identifier r.i;
> expression e1,e2,e3,e4;
> position p;
> @@
> (
> devm_rtc_device_register(e1,e2,&i@p,e3)
> |
> rtc_device_register(e1,e2,&i@p,e3)
> |
> platform_device_register_data(e1,e2,e3,&i@p,e4)
> )
> 
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> @@
> i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct rtc_class_ops i = { ... };
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
[...]
>  drivers/rtc/rtc-tegra.c      |    2 +-
[...]

Acked-by: Thierry Reding <treding@nvidia.com>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXyBJ6AAoJEN0jrNd/PrOhhWwP/iRSPG7Hcx1dFammZmPkRgM4
gOsnIhTQnRVvCaMM2rH7ZhHoMoQX+/DX1LJYBmaDejyJfAqC2SxOOdKmTCIJsGcV
UUaaWtRlQUH/VZAAX+WqkHOW6TBA3cY+6ogKN8Htmpk0luiDX7ADJCv1m2edg2Kb
HQZdeNYB/7dO9HMa9sLi1CguxrMgVYPG53iv8Kj1E3Po7pQ+qX59PRVxUwbuiVcn
2H8FLdUoIuxt2M2M4EtVNx8mVpe37RTzR9zOwXRsc7R8v7pzpCT+aY3+R5cXNwhl
pp24pwd3C+cq6nDZ8pDOiyxVG2bcuZogXkKLeA142TEWYHSLa73iafunGAsBjR84
aUVkd7tNiFGheV73DtbAmIIC/8HpGKL+3o2xmCk+aUluD9xxs+DyWO7i3kJAD9q6
JVlVSCGxTnuRjH48NawvNKrnlXiabuo5yavwcxSq4uHenYBDDZ5AlLOV60BWhF2E
BUuY1TP0xSwq69vZcBwzrOCjJ/1dKtB3rixZiTGWO9juoQ7Qp4NMqSWuJ4pe4IgG
Pk+Y5UYRpeHe+5rQvdplKzDvdHoYY4jSe5lHrLlyGAy/NiRaITEyruGZyYQKEqVD
TuzYonHbypFaAVDzaMVtVvkqBw9W/kT8FhtDF4th997coqiL3e8lqgPJ3exGJV32
+RWfcKFRdlmGct9Kw4Iu
=5U2k
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
