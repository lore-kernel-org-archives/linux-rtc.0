Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38458 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeHTSdg (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 20 Aug 2018 14:33:36 -0400
Date: Mon, 20 Aug 2018 17:17:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Keerthy <j-keerthy@ti.com>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, johan@kernel.org
Subject: Re: [PATCH v6 2/2] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Message-ID: <20180820151731.GD14967@localhost>
References: <1534396140-1161-1-git-send-email-j-keerthy@ti.com>
 <1534396140-1161-2-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1534396140-1161-2-git-send-email-j-keerthy@ti.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Aug 16, 2018 at 10:39:00AM +0530, Keerthy wrote:
> Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
> over try again.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---

You forgot to include a changelog, but it looks like you've addressed
the issues with v5, and this now looks good to me:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
