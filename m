Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41804 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbdJLOlK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 10:41:10 -0400
Date: Thu, 12 Oct 2017 16:40:59 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtc: rv3029: Clean up error handling in
 rv3029_eeprom_write()
Message-ID: <20171012144059.2253ykdnm7qmrjhz@piout.net>
References: <20170920214530.jusyjbnvkopsumrr@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170920214530.jusyjbnvkopsumrr@mwanda>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 21/09/2017 at 00:45:30 +0300, Dan Carpenter wrote:
> We don't need both "ret" and "err" when they do the same thing.  All the
> functions called here return zero on success or negative error codes.
> It's more clear to return a literal zero at the end instead of
> "return ret;"
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
