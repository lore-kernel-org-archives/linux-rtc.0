Return-Path: <rtc-linux+bncBD47PQ46SILBBFNO5PGAKGQEV46HRRI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com. [2a00:1450:400c:c0c::242])
        by gmr-mx.google.com with ESMTPS id k84si2706363wmh.5.2017.08.21.05.50.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Aug 2017 05:50:29 -0700 (PDT)
Received: by mail-wr0-x242.google.com with SMTP id 30so5324099wrk.0
        for <rtc-linux@googlegroups.com>; Mon, 21 Aug 2017 05:50:29 -0700 (PDT)
Reply-To: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] RTC used as a module
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Michal Simek <michal.simek@xilinx.com>
Cc: John Stultz <john.stultz@linaro.org>,
 "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
References: <6e9bb8fa-52e5-0a3a-38b7-57c34bcdfb6b@monstr.eu>
 <CALAqxLUWD23LWh3z8sr_hFMvrf+SmVOH-i6VHDr60uQZRyWXbA@mail.gmail.com>
 <cd325ab6-b31c-a03f-2bd3-e2e8cb99a6a5@xilinx.com>
 <8f181912-d6b1-fe2b-92ef-df2cb26f3f02@xilinx.com>
 <cc3a8f33-1d68-2ad1-6aba-773f53c29d61@xilinx.com>
 <59e7661e-7e1f-a11e-93c2-9a4bbe9ebe1a@xilinx.com>
 <20170820220329.uzx3ryehq75qruwz@piout.net>
 <44ce48f1-73bb-1b88-1e92-327e80f09f96@monstr.eu>
 <20170821121344.emzboqji3hhakzpf@piout.net>
 <ac7f1a06-a20a-3fe8-8ef1-01423d742836@xilinx.com>
 <20170821124720.cmudjhugpssjuag6@piout.net>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <007aa39d-2e1b-d919-9c53-8f03103b20db@monstr.eu>
Date: Mon, 21 Aug 2017 14:50:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170821124720.cmudjhugpssjuag6@piout.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="C6OguqxJXCSV67MccmcACXAPNtAMlLLFR"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C6OguqxJXCSV67MccmcACXAPNtAMlLLFR
Content-Type: multipart/mixed; boundary="Tnvv7SkXq1O4Osxq96bduDIv2lTowseWR";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Michal Simek <michal.simek@xilinx.com>
Cc: John Stultz <john.stultz@linaro.org>,
 "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
Message-ID: <007aa39d-2e1b-d919-9c53-8f03103b20db@monstr.eu>
Subject: Re: [rtc-linux] RTC used as a module
References: <6e9bb8fa-52e5-0a3a-38b7-57c34bcdfb6b@monstr.eu>
 <CALAqxLUWD23LWh3z8sr_hFMvrf+SmVOH-i6VHDr60uQZRyWXbA@mail.gmail.com>
 <cd325ab6-b31c-a03f-2bd3-e2e8cb99a6a5@xilinx.com>
 <8f181912-d6b1-fe2b-92ef-df2cb26f3f02@xilinx.com>
 <cc3a8f33-1d68-2ad1-6aba-773f53c29d61@xilinx.com>
 <59e7661e-7e1f-a11e-93c2-9a4bbe9ebe1a@xilinx.com>
 <20170820220329.uzx3ryehq75qruwz@piout.net>
 <44ce48f1-73bb-1b88-1e92-327e80f09f96@monstr.eu>
 <20170821121344.emzboqji3hhakzpf@piout.net>
 <ac7f1a06-a20a-3fe8-8ef1-01423d742836@xilinx.com>
 <20170821124720.cmudjhugpssjuag6@piout.net>
In-Reply-To: <20170821124720.cmudjhugpssjuag6@piout.net>

--Tnvv7SkXq1O4Osxq96bduDIv2lTowseWR
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US

On 21.8.2017 14:47, Alexandre Belloni wrote:
> On 21/08/2017 at 14:19:07 +0200, Michal Simek wrote:
>> On 21.8.2017 14:13, Alexandre Belloni wrote:
>>> On 21/08/2017 at 12:50:34 +0200, Michal Simek wrote:
>>>> Hi,
>>>>
>>>> On 21.8.2017 00:03, Alexandre Belloni wrote:
>>>>> Hi Michal,
>>>>>
>>>>> I've just send a patch to fix this issue (and avoid your other patch).
>>>>>
>>>>> Could you test it? (I did test on an atmel platform)
>>>>>
>>>>> Sorry it took so long!
>>>>
>>>> not a problem but it looks like it is still just temporary solution. I
>>>> would expect that you can't unload module when this alarm is used. It if
>>>> it is not used then you should be able to remove it.
>>>>
>>>
>>> Yes, the alarmtimer handling needs to be made more flexible, especially
>>> in the rtc device selection.
>>
>> ok. What about to extend that commit message for the patch you sent to
>> explicitly say that this is temporary solution and what should be the
>> right fix?
>>
>> Maybe you can also add link that patch which introduced this issue.
>> It was in that patch I sent.
>>
> 
> You didn't pinpoint the correct patch. The patch introducing the issue
> you were seeing (i.e. being able to remove the module) is
> 8bc0dafb5cf38a19484dfb16e2c6d29e85820046. Before this patch,
> rtc_class_open() was called and this prevented the module from being
> removed (it does try_module_get). For now, this is how the feature has
> been implemented since 2011 and nobody cared enough to change that
> behaviour.

ok but still isn't worth to mentioned it in commit message?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--Tnvv7SkXq1O4Osxq96bduDIv2lTowseWR--

--C6OguqxJXCSV67MccmcACXAPNtAMlLLFR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlma1wQACgkQykllyylKDCHVhgCdHajFVWFmjc1KHRPKX8hTepcm
xMUAn2Ab+4xrIuk342fAw+h/qJCCQYVK
=aUYw
-----END PGP SIGNATURE-----

--C6OguqxJXCSV67MccmcACXAPNtAMlLLFR--
