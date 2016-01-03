Return-Path: <rtc-linux+bncBDZJXP7F6YLRB5VUUW2AKGQE2HI6QEQ@googlegroups.com>
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr. [192.134.164.83])
        by gmr-mx.google.com with ESMTPS id f18si1512312wme.1.2016.01.03.09.29.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2016 09:29:25 -0800 (PST)
Date: Sun, 3 Jan 2016 18:29:24 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: SF Markus Elfring <elfring@users.sourceforge.net>
cc: Julia Lawall <julia.lawall@lip6.fr>, rtc-linux@googlegroups.com,
    Alessandro Zummo <a.zummo@towertech.it>,
    Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 8/8] rtc-ab-b5ze-s3: Delete an unnecessary
 variable in _abb5zes3_rtc_set_timer()
In-Reply-To: <56895976.5040009@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1601031827340.2074@localhost6.localdomain6>
References: <566ABCD9.1060404@users.sourceforge.net> <5688DF2D.6090204@users.sourceforge.net> <5688E268.9090600@users.sourceforge.net> <alpine.DEB.2.02.1601031345240.2053@localhost6.localdomain6> <56895976.5040009@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-719743927-1451842165=:2074"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-719743927-1451842165=:2074
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: 8BIT

On Sun, 3 Jan 2016, SF Markus Elfring wrote:

> >>  	ret = regmap_update_bits(data->regmap, ABB5ZES3_REG_TIM_CLK,
> >> -				 mask, ABB5ZES3_REG_TIM_CLK_TAC1);
> >> +				 ABB5ZES3_REG_TIM_CLK_TAC0
> >> +				 | ABB5ZES3_REG_TIM_CLK_TAC1,
> >> +				 ABB5ZES3_REG_TIM_CLK_TAC1);
> > 
> > This doesn't seem like an improvement.
> 
> Interesting …
> 
> 
> > The concept (mask) has disappeared,
> 
> I suggest to drop another local variable.
> Can the operator "Bitwise OR" be sufficient to indicate the concept "mask"?
> 
> 
> > the binary operation is strangely broken,
> 
> Do you prefer an other source code formatting within the usual line length range?
> 
> 
> > and the function call has one more line of arguments,
> 
> How should several long preprocessor symbols be combined together with indentation
> so that they will fit into the limit of 80 characters?
> 
> 
> > which all look sort of the same and thus are hard to understand.
> 
> Is this an usual consequence from an ordinary name pattern?

The original code was better.  No 80 character problem, easy to 
distinguish one argument from another, moderately meaningful variable 
name, etc.

julia
--8323328-719743927-1451842165=:2074--
