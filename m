Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:39668 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbeHBKUo (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 2 Aug 2018 06:20:44 -0400
Date: Thu, 2 Aug 2018 10:30:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/8] char: rtc: remove task handling
Message-ID: <20180802083036.GA12755@kroah.com>
References: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
 <20180726134056.18273-8-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180726134056.18273-8-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jul 26, 2018 at 03:40:55PM +0200, Alexandre Belloni wrote:
> Since commit 9e7002a70e42 ("char: rtc: remove unused rtc_control() API"),
> it is not possible to set a callback anymore, remove its handling from the
> interrupt handler.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> Hi,
> 
> My plan is to take that patch through the RTC tree because the next patch relies
> on the rtc_task_t *rtc_callback removal.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
