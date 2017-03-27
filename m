Return-Path: <rtc-linux+bncBDXMLNOH5ANRBNWB4TDAKGQEWKGBG3Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id 2si122627pfz.1.2017.03.27.07.24.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Mar 2017 07:24:54 -0700 (PDT)
Date: Mon, 27 Mar 2017 16:24:43 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: cpcap: fix improper use of IRQ_NONE for request_threaded_irq
Message-ID: <20170327142443.zkaiieehqeirk4pi@earth>
References: <20170327033423.4536-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jpup43qwdneg7hvx"
In-Reply-To: <20170327033423.4536-1-tony@atomide.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--jpup43qwdneg7hvx
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Sun, Mar 26, 2017 at 08:34:23PM -0700, Tony Lindgren wrote:
> There's a funny typo where IRQ_NONE is used instead of IRQF_TRIGGER_NONE
> for request_threaded_irq(). Let's fix it before it gets copied elsewhere.
> 
> Fixes: dd3bf50b35e3 ("rtc: cpcap: new rtc driver")
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

> ---
>  drivers/rtc/rtc-cpcap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-cpcap.c b/drivers/rtc/rtc-cpcap.c
> --- a/drivers/rtc/rtc-cpcap.c
> +++ b/drivers/rtc/rtc-cpcap.c
> @@ -275,7 +275,7 @@ static int cpcap_rtc_probe(struct platform_device *pdev)
>  
>  	rtc->alarm_irq = platform_get_irq(pdev, 0);
>  	err = devm_request_threaded_irq(dev, rtc->alarm_irq, NULL,
> -					cpcap_rtc_alarm_irq, IRQ_NONE,
> +					cpcap_rtc_alarm_irq, IRQF_TRIGGER_NONE,
>  					"rtc_alarm", rtc);
>  	if (err) {
>  		dev_err(dev, "Could not request alarm irq: %d\n", err);
> @@ -291,7 +291,7 @@ static int cpcap_rtc_probe(struct platform_device *pdev)
>  	 */
>  	rtc->update_irq = platform_get_irq(pdev, 1);
>  	err = devm_request_threaded_irq(dev, rtc->update_irq, NULL,
> -					cpcap_rtc_update_irq, IRQ_NONE,
> +					cpcap_rtc_update_irq, IRQF_TRIGGER_NONE,
>  					"rtc_1hz", rtc);
>  	if (err) {
>  		dev_err(dev, "Could not request update irq: %d\n", err);
> -- 
> 2.12.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--jpup43qwdneg7hvx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljZIKgACgkQ2O7X88g7
+prQjA//SNVOu2zJaIhxg8dL9d/lZBDrhHZuw5kTJvJ4B9XyaP7tvEplhuHAy+NY
XaVnyDAhMl5FlfTI3PjujI8qpuV+S3tP2zVcH5yRDdsfNMS6rPqUMwt7ClVzYCg2
GJ6UmdeYBFNF/UhcL3WTFK62Gbzd62RRw04Y33UE4S5vBwIJIVienKXVo8230CvY
IzalWHspIyJd+kP/ec86T3Oiws9LC2847QWQXAajyrYCO65rDBFCJhLq6jOhhfxw
NWY9JUbM3ksStM3QjHv1ZyPtJsJ9/qiRvv4IoQlWUEfRWtdfJwzI99SVH3BtUWPB
Nye6XIrOgquTPlNMI2+2AxQDEs2CAPDKum4xe8+IcP2meB6p5a6P09J1/ajb/Eid
+QLHBN0jg8WoNN/ITJ6PgfSWxpMdLkMQ6wLXiVT1MJEmHBLdeL66EvWPLkp7U+ml
hAdFpbad/lTL4ZoILr/A2uluXO4iqJAmv4b+UCKHdi2k+5DLKybvgBMlwhDw+b+J
9GKUBTvKsKF9hv2okBU29ZmJeOanh7JBPhkgbzEtjfJW7cX/e3ThXFYh5aPV7QHu
F8XE5QBI9d18Ha3AXAEw/YsFSyTo1DdsUB98cBnJp2a/szJDgu2vWPFmQgBfCP/z
w31Ca9/VbE7G1dO8zXPRESDrJmA2qNfPwfJixdlucYqowejoxAg=
=yjr5
-----END PGP SIGNATURE-----

--jpup43qwdneg7hvx--
