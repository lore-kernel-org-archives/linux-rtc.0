Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.147]:29418 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1424685AbeCBJGb (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 2 Mar 2018 04:06:31 -0500
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: RE: [PATCH 000/100] rtc: remove cargo culted code
Date: Fri, 2 Mar 2018 09:06:28 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB70194158130@SW-EX-MBX01.diasemi.com>
References: <6ED8E3B22081A4459DAC7699F3695FB701941570C7@SW-EX-MBX01.diasemi.com>
 <20180302085654.GA1479@piout.net>
In-Reply-To: <20180302085654.GA1479@piout.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 02 March 2018 08:57, Alexandre Belloni wrote:

> To: Steve Twiss
> Cc: linux-kernel@vger.kernel.org; linux-rtc@vger.kernel.org
> Subject: Re: [PATCH 000/100] rtc: remove cargo culted code
> 
> On 02/03/2018 at 08:46:48 +0000, Steve Twiss wrote:
> > Hi Alexandre,
> >
> > Acked for:
> >   rtc: da9063: stop validating rtc_time in .read_time
> >   rtc: da9052: stop validating rtc_time in .read_time
> >   rtc: da9055: stop validating rtc_time in .read_time
> >
> > Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
> >

[...]

> > But after some further looking, I have not got any explicit case of how the
> > time read directly from the DA9063
> > registers can be incorrectly represented. So there should be no need to
> > check this.
> 
> My point is that it is checked later in the core anyway so you end up
> doing:
> 
> da9063_rtc_read_time()
> 	return rtc_valid_tm(tm);
> 
> __rtc_read_time()
> 	if (err < 0)
> 		return err;
> 	err = rtc_valid_tm(tm);
> 
> 	return err;
> 
> So the check in da9063_rtc_read_time is always pointless.

Ahh. I see. Thanks!
Regards,
Steve
