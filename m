Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:38184 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753755AbeCFOuw (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 6 Mar 2018 09:50:52 -0500
Date: Tue, 6 Mar 2018 15:50:50 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Mohit Aggarwal <maggarwa@codeaurora.org>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtc-pm8xxx: Fix issue in RTC write path
Message-ID: <20180306145050.GV3035@piout.net>
References: <1520240758-9837-1-git-send-email-maggarwa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1520240758-9837-1-git-send-email-maggarwa@codeaurora.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 05/03/2018 at 14:35:58 +0530, Mohit Aggarwal wrote:
> In order to set time in rtc, need to disable
> rtc hw before writing into rtc registers.
> 
> Also fixes disabling of alarm while setting
> rtc time.
> 
> Signed-off-by: Mohit Aggarwal <maggarwa@codeaurora.org>
> ---
>  drivers/rtc/rtc-pm8xxx.c | 49 +++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 38 insertions(+), 11 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
