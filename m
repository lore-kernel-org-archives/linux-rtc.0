Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35523 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752605AbeFYCCV (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 24 Jun 2018 22:02:21 -0400
Date: Mon, 25 Jun 2018 09:58:32 +0800
From: Greg KH <greg@kroah.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH 5/9] rtc: cros-ec: Switch to SPDX identifier.
Message-ID: <20180625015832.GB30408@kroah.com>
References: <20180605092209.22887-1-enric.balletbo@collabora.com>
 <20180605092209.22887-6-enric.balletbo@collabora.com>
 <20180605094626.GC4637@piout.net>
 <39af6363-ce08-a227-f66a-4c7bd4916596@collabora.com>
 <20180605185952.GG4637@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180605185952.GG4637@piout.net>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, Jun 05, 2018 at 08:59:52PM +0200, Alexandre Belloni wrote:
> On 05/06/2018 20:51:06+0200, Enric Balletbo i Serra wrote:
> > Hi Alexandre,
> > 
> > On 05/06/18 11:46, Alexandre Belloni wrote:
> > > On 05/06/2018 11:22:05+0200, Enric Balletbo i Serra wrote:
> > >> Adopt the SPDX license identifier headers to ease license compliance
> > >> management.
> > >>
> > >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > >> ---
> > >>
> > >>  drivers/rtc/rtc-cros-ec.c | 21 +++++----------------
> > >>  1 file changed, 5 insertions(+), 16 deletions(-)
> > >>
> > > Applied, thanks.
> > > 
> > 
> > Looks like all the ChromeOS drivers should be licensed as GPL v2 only. There was
> > a mismatch between what the header says and the MODULE_LICENSE and I wrongly
> > assumed that the MODULE_LICENSE is the one I should follow. So could you not
> > apply this patch for now and I'll send another version with the correct license?
> > 
> 
> Hum, ok, this seemed to be the correct way to solve the mismatch to me.

No, the license text trumps the MODULE_LICENSE() string.  Please revert
this, or fix it up to be correct.

thanks,

greg k-h
