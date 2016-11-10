Return-Path: <rtc-linux+bncBDZKLXNI4ACBBG6CSLAQKGQENYIBTWA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz. [195.113.26.193])
        by gmr-mx.google.com with ESMTPS id y7si602552wme.0.2016.11.10.08.32.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Nov 2016 08:32:27 -0800 (PST)
Date: Thu, 10 Nov 2016 17:32:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	John Stultz <john.stultz@linaro.org>,
	Xunlei Pang <xlpang@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Len Brown <lenb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [rtc-linux] Re: [PATCH][RFC v7] timekeeping: Ignore the bogus sleep
 time if pm_trace is enabled
Message-ID: <20161110163225.GB28832@amd>
References: <1478753753-24650-1-git-send-email-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
In-Reply-To: <1478753753-24650-1-git-send-email-yu.c.chen@intel.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu 2016-11-10 12:55:53, Chen Yu wrote:
> Previously we encountered some memory overflow issues due to
> the bogus sleep time brought by inconsistent rtc, which is
> triggered when pm_trace is enabled, and we have fixed it
> in recent kernel. However it's improper in the first place
> to call __timekeeping_inject_sleeptime() in case that pm_trace
> is enabled simply because that "hash" time value will wreckage
> the timekeeping subsystem.
> 
> This patch is originally written by Thomas, which would bypass
> the bogus rtc interval when pm_trace is enabled.
> Meanwhile, if system succeed to resume back with pm_trace set, the
> users are warned to adjust the bogus rtc either by ntp-date or rdate,
> by resetting pm_trace_rtc_abused to false, otherwise above tools might
> not work as expected.
> 
> Originally-from: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Xunlei Pang <xlpang@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgkoRkACgkQMOfwapXb+vInGwCeO/tO7n3b6h8UqrwbTEfHFJao
ffMAoKKMmCqR94o6UdIZCOUM3/97FfGu
=m3m3
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
