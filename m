Return-Path: <rtc-linux+bncBDY3NC743AGBBA5STS3QKGQECK46YIA@googlegroups.com>
Received: from smtprelay.hostedemail.com (smtprelay0068.hostedemail.com. [216.40.44.68])
        by gmr-mx.google.com with ESMTPS id k15si1064317igt.3.2016.03.14.13.03.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Mar 2016 13:03:15 -0700 (PDT)
Message-ID: <1457985791.11972.128.camel@perches.com>
Subject: [rtc-linux] Re: [PATCH] rtc: s3c: Don't print an error on probe deferral
From: Joe Perches <joe@perches.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-kernel@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski
 <k.kozlowski@samsung.com>,  rtc-linux@googlegroups.com
Date: Mon, 14 Mar 2016 13:03:11 -0700
In-Reply-To: <56E71825.5070104@osg.samsung.com>
References: <1457982308-29848-1-git-send-email-javier@osg.samsung.com>
	 <1457982675.11972.119.camel@perches.com> <56E7119B.9060900@osg.samsung.com>
	 <1457984317.11972.123.camel@perches.com> <56E71825.5070104@osg.samsung.com>
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, 2016-03-14 at 16:59 -0300, Javier Martinez Canillas wrote:
> I don't think they make little sense now since even a non-native english
> speaker like me can understand it :)

That's a non sequitur if ever I read one.

> But yes, it's cryptic at the very least. That's the problem with long tex=
t
> and the 80 char limit to make checkpatch.pl happy. I guess I can just mov=
e
> the message a little bit even if that will make to not be properly aligne=
d.

There's no issue with longer than 80 column lines
for these messages. =C2=A0checkpatch wouldn't complain.

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
