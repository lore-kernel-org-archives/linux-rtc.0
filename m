Return-Path: <rtc-linux+bncBDU7VC56WAFBB27V2G3AKGQEG7BBRDQ@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id w197si642729wmw.3.2016.02.29.09.07.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 09:07:55 -0800 (PST)
Date: Mon, 29 Feb 2016 18:07:49 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] rv3029 EEPROM handling
Message-ID: <20160229180749.42f75ec8@wiggum>
In-Reply-To: <20160228213920.GA2260@piout.net>
References: <20160227153918.3c3d3853@wiggum>
 <20160228003139.GB2398@piout.net>
 <20160228094452.132c1938@wiggum>
 <20160228104110.GC2398@piout.net>
 <20160228125852.1a0b271e@wiggum>
 <20160228123618.GD2398@piout.net>
 <20160228181450.3ba14f7f@wiggum>
 <20160228213920.GA2260@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zgiuCLE4DfqdTatTT4cj4/."; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/zgiuCLE4DfqdTatTT4cj4/.
Content-Type: text/plain; charset=UTF-8

On Sun, 28 Feb 2016 22:39:20 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> > The rv3029 has a clkout pin that can be configured to various
> > frequencies. So I added a 'clkout-hz' property for this.
> >   
> 
> No, you have to use the CCF for that.

Oh, yes. That makes sense.

> I had a really quick look, I'll review when you post patches. Please
> separate each functionality when submitting and use checkpatch.pl --strict

Yes, of course. Thanks for the hint. I'm not submitting stuff for the
first time, though. :)

> Also, to export the temperature, use hwmon, see:
> http://git.kernel.org/cgit/linux/kernel/git/abelloni/linux.git/commit/?h=rtc-next&id=445c02076f1e60d2ee51503bf1288ef9f3bc8809

That is a rather weird API.
Is there a special naming scheme required for the attribute?
What does the 'input' mean in 'temp1_input'? And why is it temp1
instead of temp0?

> You may want to use regmap instead of defining your own update_bits
> (rv3029c2_i2c_maskset_reg) but that is a more invasie change that you
> may leave out for now.

Ok, I will do this last.
Don't hold your breath. :)

-- 
Michael

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--Sig_/zgiuCLE4DfqdTatTT4cj4/.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1HrlAAoJEPUyvh2QjYsOTPEQAJefyO2w/yAbZnX4jCBoSXJy
vLc0gpFfaY7w/gFvhlFKJLZO8E4zYaCLe1Lvjfp5wA2lRt9WABSAYnP1sbdnGHdB
G5D7C2hacT4/N2PfCeFJnMfhM+M7viz/HqRtmsL8GOYPE0U8EZeO4CLZw4HBBGx4
l/iT6y2+0PS76OOLgZUV2U+X3WD3la53lXg2XDr1YnmmwCuxjhiK1WszMCRUK+Hn
3Dq3Td8t+wKw8bJ4/uW7ki6KVBWktd7iuuCbcgPqExkuJ8cB/UxuD/fyBt0wzgZn
iwFbJbJmCb2l72HYqU0nanxXDIjX3FLCC3opug2M7T8CfgXGz4Xe3C4WUkyynrZ2
qGQCP0sCKmQydsb42OL4pG7MnOOXX7WBaPt80njsD8LUQQ7nF1r7fnCKPAS0cMSF
1SVtoHjitsptr/Qm73TW7CO9BeUSNCjEBQk6wgzrnyPhnsXld87Ap/EX94A8EwLL
xgDIkUKFFPe761Y+jLt3NmtxcQ/87D+6cQB7DHZZaijhjU2jvwykD4qLeujQSTZ+
b1nszbickGo5By6KBAChXO8LAMlryKFaeNvB2wZOjZfHu5hMPw5/gi4glQRiNKph
S79BZrLmfqjNBhkFAX6jShgDZHUR/GzmSTaeSRrqx9u0gGWCXEZ4Aycq4oOMPWzR
YeRuPCQgo1bHFwydF/70
=vbIm
-----END PGP SIGNATURE-----

--Sig_/zgiuCLE4DfqdTatTT4cj4/.--
