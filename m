Return-Path: <rtc-linux+bncBDXMLNOH5ANRBX6PU3DAKGQEHTRZIJY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id a3si554462pfb.2.2017.03.15.13.45.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Mar 2017 13:45:18 -0700 (PDT)
Date: Wed, 15 Mar 2017 21:45:13 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Guy Shapiro <guy.shapiro@mobi-wize.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-pm@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH 1/2] power: reset: syscon-poweroff: add a mask property
Message-ID: <20170315204513.i3cpl4ptyevtyyp5@earth>
References: <1486472054-4367-1-git-send-email-guy.shapiro@mobi-wize.com>
 <1486482966-4497-1-git-send-email-guy.shapiro@mobi-wize.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wspwyo7wchrwmhxp"
In-Reply-To: <1486482966-4497-1-git-send-email-guy.shapiro@mobi-wize.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--wspwyo7wchrwmhxp
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Tue, Feb 07, 2017 at 05:56:05PM +0200, Guy Shapiro wrote:
> Make the syscon-poweroff driver accept value and mask instead of
> just value.
> 
> Prior to this patch, the property name for the value was 'mask'. If
> only the mask property is defined on a node, maintain compatibility
> by using it as the value.
> 
> Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>

Thanks, queued with Rob's Acked-By.

-- Sebastian

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--wspwyo7wchrwmhxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJp9cACgkQ2O7X88g7
+poUXg//YVvSVFLN+yCg282zEWVPHRSG0sqsj14LykFmOBm6P/x6wlzDRm57AQ6t
RAwigdpSzPdi7BEjXnvNDv2oHx0xd3h52wSx3NdxUHUxQfa3D0K/eNU+LK4HbdB6
Whs0gaRYC4D1SjWrZ6+GFWSDSfIW/r8CBEUTF6MG5uIy1F1ErIVzKeX80KOM+I8I
2eNj6wV2Lq8z5HSrt+Mswmsm5PaKUwucs1zNrl2f56tjkh0DmReXXoB1arYuzoVz
MiRwPlIZq4MOzAwsHf3sH3SIj4NBeMi4Q14O3aS2BsxmvNSUxV2PuMhmMLZ0FzqB
K973y9yS4yuKCNONY4AVEFen0d12jzs74UhNCHLcZBDH9ecX8DaHbDGsKEkgPaSX
BluMFrdBy0kCTkZJKLGVLMwSEtLRmLV4qDjKX4UgW8264uEqJnHV57tMw7LX+BCc
dIxGBWu/r8PrrfuXwUAzVslTEGbA+Agtp6Asz36ZuS+B55J/Dl3/q/j8XjKhgvSe
tlBD1ZxVszngAqbhQ4s1xMOWuHWvVNo55asg1MrmTsGMQJfffAOxxqoxTTIMTbw3
C/h9JJwn/Vm1GPdJaFlMvebKYMDZIu63zKBgbltEc5WkYnSr1yVyiSLWJcUb9AHg
A2rl70vxMLWglhCSqKNGLmlgY4PMZ9YoPmtsmIvkSQFVv6iQa1M=
=auno
-----END PGP SIGNATURE-----

--wspwyo7wchrwmhxp--
