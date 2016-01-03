Return-Path: <rtc-linux+bncBCOML4NU3EDRB6VSUW2AKGQEI3DVNAY@googlegroups.com>
Received: from mout.web.de (mout.web.de. [212.227.17.11])
        by gmr-mx.google.com with ESMTPS id 202si2367517wmf.2.2016.01.03.09.25.14
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2016 09:25:14 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 8/8] rtc-ab-b5ze-s3: Delete an unnecessary
 variable in _abb5zes3_rtc_set_timer()
To: Julia Lawall <julia.lawall@lip6.fr>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5688DF2D.6090204@users.sourceforge.net>
 <5688E268.9090600@users.sourceforge.net>
 <alpine.DEB.2.02.1601031345240.2053@localhost6.localdomain6>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <56895976.5040009@users.sourceforge.net>
Date: Sun, 3 Jan 2016 18:25:10 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1601031345240.2053@localhost6.localdomain6>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

>>  	ret =3D regmap_update_bits(data->regmap, ABB5ZES3_REG_TIM_CLK,
>> -				 mask, ABB5ZES3_REG_TIM_CLK_TAC1);
>> +				 ABB5ZES3_REG_TIM_CLK_TAC0
>> +				 | ABB5ZES3_REG_TIM_CLK_TAC1,
>> +				 ABB5ZES3_REG_TIM_CLK_TAC1);
>=20
> This doesn't seem like an improvement.

Interesting =E2=80=A6


> The concept (mask) has disappeared,

I suggest to drop another local variable.
Can the operator "Bitwise OR" be sufficient to indicate the concept "mask"?


> the binary operation is strangely broken,

Do you prefer an other source code formatting within the usual line length =
range?


> and the function call has one more line of arguments,

How should several long preprocessor symbols be combined together with inde=
ntation
so that they will fit into the limit of 80 characters?


> which all look sort of the same and thus are hard to understand.

Is this an usual consequence from an ordinary name pattern?

Regards,
Markus

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
