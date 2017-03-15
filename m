Return-Path: <rtc-linux+bncBDXMLNOH5ANRBUP2UXDAKGQEFSXNJZA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id 2si473988pfx.8.2017.03.15.10.43.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Mar 2017 10:43:44 -0700 (PDT)
Date: Wed, 15 Mar 2017 18:43:38 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com, kernel-janitors@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: cpcap: kfreeing devm allocated memory
Message-ID: <20170315174337.4osgmj2reiw7v6pe@earth>
References: <20170314075319.GB6111@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t4xzvzp5f235vgrw"
In-Reply-To: <20170314075319.GB6111@mwanda>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--t4xzvzp5f235vgrw
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Tue, Mar 14, 2017 at 10:56:30AM +0300, Dan Carpenter wrote:
> We shouldn't kfree(rtc) because is devm_ managed memory.  It leads to a
> double free.
> 
> Fixes: dd3bf50b35e3 ("rtc: cpcap: new rtc driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/rtc/rtc-cpcap.c b/drivers/rtc/rtc-cpcap.c
> index 7c6a3c3167bd..5d163be98e9f 100644
> --- a/drivers/rtc/rtc-cpcap.c
> +++ b/drivers/rtc/rtc-cpcap.c
> @@ -266,10 +266,8 @@ static int cpcap_rtc_probe(struct platform_device *pdev)
>  	rtc->rtc_dev = devm_rtc_device_register(dev, "cpcap_rtc",
>  						&cpcap_rtc_ops, THIS_MODULE);
>  
> -	if (IS_ERR(rtc->rtc_dev)) {
> -		kfree(rtc);
> +	if (IS_ERR(rtc->rtc_dev))
>  		return PTR_ERR(rtc->rtc_dev);
> -	}
>  
>  	err = cpcap_get_vendor(dev, rtc->regmap, &rtc->vendor);
>  	if (err)

Acked-By: Sebastian Reichel <sre@kernel.org>

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

--t4xzvzp5f235vgrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJfUcACgkQ2O7X88g7
+poVmRAAowLrctzOvgnR6mmMXs+9u4PNtSF7QsGkY8/ql3It7q1FP5B8KLZ3g48L
0Y7gRqZiIYWvEmcSdHjFZjy+cSp8AcVFuJYZwf4/MvAk4ZBFuISmt0TAGZyOH89J
MQNaDJZZd0BisWVXLNKKMXfO/loN8nzhwvobeTtT3sbCZJ+HfvSNIfva9p2tlqTk
dAA7RcY5Y9XlKHSNVJmiAk0lcGch201ap2Gstz2m266H8WUdlbzBQoL/VMAc0aij
YLozLIhAoc0LzW21kgnah5kZR4F5knS57I/AsmeloSm2lFq4cjGbU/0ecTmo2XAX
KJg3JnWlf53hwWuNZrlLMoYULkrqtlF5YbK8bATgn8UrURVtmfrmWzxEELznjcyu
tkMlskrrLEWP/bYmPTp8lmbMYzkxk3RAe6f+IGeP29h5//E2vaIGtMJvlM1QCweC
4CGA0/uJrFqFLOM0Qq6c2RXsO6kBTIC0eF0p8VCei4vub5jZgbTsM10+5IGIwJxU
sZDEXqbAoPIxNQUNFBHy/AR3aFAx7PJwjbsS9xZ0KWAJl4mo61Ad+sWg+mimaQPU
MA/4wxOdqIlTpbVHQQGWMQgSLjROGrBIHtsTx2RmqpYfK0h7i3XV7cVtsRGI3Ty4
xcyp9jgfCO1C6Kr9KmLRgXu6lPXNvuSBkQnMFyZ0WrnBSh4Md1E=
=tbsb
-----END PGP SIGNATURE-----

--t4xzvzp5f235vgrw--
