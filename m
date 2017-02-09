Return-Path: <rtc-linux+bncBDSJBYGBRIMBBGNX6DCAKGQE2DJPF2Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id d5si259621wmc.1.2017.02.08.23.34.49
        for <rtc-linux@googlegroups.com>;
        Wed, 08 Feb 2017 23:34:49 -0800 (PST)
Date: Thu, 9 Feb 2017 08:34:48 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>, Wei Yongjun <weiyongjun1@huawei.com>,
	rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH -next] rtc: sun6i: Fix return value check in sun6i_rtc_clk_init()
Message-ID: <20170209073448.ua6qtptmpdjkren6@lukather>
References: <20170209001613.21665-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b2oeurynxati5w6f"
In-Reply-To: <20170209001613.21665-1-weiyj.lk@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--b2oeurynxati5w6f
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Feb 09, 2017 at 12:16:13AM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> In case of error, the function of_io_request_and_map() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Fixes: 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--b2oeurynxati5w6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYnBuUAAoJEBx+YmzsjxAg5+wQAK+KsQG1sqOvxlGk/pSN3f7C
DXF2aZHuohz4daQWSjINQOFimKYmmIn0hh5S7vA7klHBIXVFgajVF4jg5hSwYhAk
aSqHXLsDU0PUTCuBZqmJYP+rY3i1fjxa+pq0u1u8onh+IIz0Ajq4OBFP7FJSuqQT
vrDmhqr/tYlUJi8RE702BKWroyHRgQFL9oDGdijQhPdgTp21RHCu6RU6nGH5Iryn
s7GPS06v+hOuhbAX+5S5bsz1EB6QqT6Tud6Xz7pAaTDg8LcnxFLK1jc6qpmdul7e
wMQq2m/i3tPUcyCGwdJ5NKY0bVURHP9Y5ocKCDn0HbVHz3Jg65s5t1KYJBJj5R6m
e4ybmSb7h7J/xaoc46erd3O73326MZFIpc58IQzEZ9NJGD1K/18WuZLBNBIWw24M
AFsYA0nRDjUdjdorFDerFXVFppVzJRvq09cOoBqtXsLpxO3wgYZ+Wi7JbQBy0Esv
/LfDzaBi0BQ6qr5G53FqMy2YhPA9kYilDzqI22ERwY0NyGCgmaBNZYcd9eZnSLJ4
vj1ReNBQOmeAdiHR1X6EtrhBWfI5Vj4Flvp2u/V/v2abc9M1+eK7cN1uyuZRTt1d
8xLZWuZc8Adu6gDjCaFhu9vfb33ReZJZbWQTR8hrQV0zPGF65xtXv8oFf0i0zp+p
bdFBb+cWRnsfdBbqPK5q
=tCZC
-----END PGP SIGNATURE-----

--b2oeurynxati5w6f--
