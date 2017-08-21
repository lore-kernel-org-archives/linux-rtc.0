Return-Path: <rtc-linux+bncBD47PQ46SILBBAXW5LGAKGQEHBQL56A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com. [2a00:1450:400c:c0c::244])
        by gmr-mx.google.com with ESMTPS id e126si170950wmd.8.2017.08.21.03.50.41
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Aug 2017 03:50:41 -0700 (PDT)
Received: by mail-wr0-x244.google.com with SMTP id 30so4796641wrk.0
        for <rtc-linux@googlegroups.com>; Mon, 21 Aug 2017 03:50:41 -0700 (PDT)
Reply-To: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] RTC used as a module
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Michal Simek <michal.simek@xilinx.com>
Cc: John Stultz <john.stultz@linaro.org>,
 "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
References: <d55404da-fe29-675d-1f3b-008145a6c87b@monstr.eu>
 <20170223121426.i24ssrlwitrvb32h@piout.net>
 <232e7023-4571-3a91-2366-753a1479c52a@monstr.eu>
 <6e9bb8fa-52e5-0a3a-38b7-57c34bcdfb6b@monstr.eu>
 <CALAqxLUWD23LWh3z8sr_hFMvrf+SmVOH-i6VHDr60uQZRyWXbA@mail.gmail.com>
 <cd325ab6-b31c-a03f-2bd3-e2e8cb99a6a5@xilinx.com>
 <8f181912-d6b1-fe2b-92ef-df2cb26f3f02@xilinx.com>
 <cc3a8f33-1d68-2ad1-6aba-773f53c29d61@xilinx.com>
 <59e7661e-7e1f-a11e-93c2-9a4bbe9ebe1a@xilinx.com>
 <20170820220329.uzx3ryehq75qruwz@piout.net>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <44ce48f1-73bb-1b88-1e92-327e80f09f96@monstr.eu>
Date: Mon, 21 Aug 2017 12:50:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170820220329.uzx3ryehq75qruwz@piout.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7ntr06RnH2hmcuOaPrDiiWsW9DlEDJ61m"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7ntr06RnH2hmcuOaPrDiiWsW9DlEDJ61m
Content-Type: multipart/mixed; boundary="D6iLa9oCIC0ndo4DE7xAppKcAT5UlLVuE";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Michal Simek <michal.simek@xilinx.com>
Cc: John Stultz <john.stultz@linaro.org>,
 "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
Message-ID: <44ce48f1-73bb-1b88-1e92-327e80f09f96@monstr.eu>
Subject: Re: [rtc-linux] RTC used as a module
References: <d55404da-fe29-675d-1f3b-008145a6c87b@monstr.eu>
 <20170223121426.i24ssrlwitrvb32h@piout.net>
 <232e7023-4571-3a91-2366-753a1479c52a@monstr.eu>
 <6e9bb8fa-52e5-0a3a-38b7-57c34bcdfb6b@monstr.eu>
 <CALAqxLUWD23LWh3z8sr_hFMvrf+SmVOH-i6VHDr60uQZRyWXbA@mail.gmail.com>
 <cd325ab6-b31c-a03f-2bd3-e2e8cb99a6a5@xilinx.com>
 <8f181912-d6b1-fe2b-92ef-df2cb26f3f02@xilinx.com>
 <cc3a8f33-1d68-2ad1-6aba-773f53c29d61@xilinx.com>
 <59e7661e-7e1f-a11e-93c2-9a4bbe9ebe1a@xilinx.com>
 <20170820220329.uzx3ryehq75qruwz@piout.net>
In-Reply-To: <20170820220329.uzx3ryehq75qruwz@piout.net>

--D6iLa9oCIC0ndo4DE7xAppKcAT5UlLVuE
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US

Hi,

On 21.8.2017 00:03, Alexandre Belloni wrote:
> Hi Michal,
> 
> I've just send a patch to fix this issue (and avoid your other patch).
> 
> Could you test it? (I did test on an atmel platform)
> 
> Sorry it took so long!

not a problem but it looks like it is still just temporary solution. I
would expect that you can't unload module when this alarm is used. It if
it is not used then you should be able to remove it.

Thanks,
Michal

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--D6iLa9oCIC0ndo4DE7xAppKcAT5UlLVuE--

--7ntr06RnH2hmcuOaPrDiiWsW9DlEDJ61m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlmauvoACgkQykllyylKDCEtdACffRTxnDXYeigXAbFCGKuvgYqd
NnsAn0A3SuTAmR2n/cFbHOL+BWdkMqcO
=qpTS
-----END PGP SIGNATURE-----

--7ntr06RnH2hmcuOaPrDiiWsW9DlEDJ61m--
