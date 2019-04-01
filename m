Return-Path: <SRS0=n38N=SD=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054F6C10F05
	for <linux-rtc@archiver.kernel.org>; Mon,  1 Apr 2019 16:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D142133D
	for <linux-rtc@archiver.kernel.org>; Mon,  1 Apr 2019 16:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfDAQ0E (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:26:04 -0400
Received: from smtprelay0066.hostedemail.com ([216.40.44.66]:55774 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728499AbfDAQ0E (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 1 Apr 2019 12:26:04 -0400
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Apr 2019 12:26:03 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id B22F8180219EB
        for <linux-rtc@vger.kernel.org>; Mon,  1 Apr 2019 16:17:02 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id C7ED6180B5B6B;
        Mon,  1 Apr 2019 16:17:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: heat78_3d1cabea1381a
X-Filterd-Recvd-Size: 1914
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon,  1 Apr 2019 16:16:59 +0000 (UTC)
Message-ID: <371999940784dbd281669122c3027805ab0ecfd9.camel@perches.com>
Subject: Re: [PATCH 02/12] rtc: pcf85063: convert to SPDX identifier
From:   Joe Perches <joe@perches.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 01 Apr 2019 09:16:58 -0700
In-Reply-To: <20190401160816.17859-2-alexandre.belloni@bootlin.com>
References: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
         <20190401160816.17859-2-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 2019-04-01 at 18:08 +0200, Alexandre Belloni wrote:
> Use SPDX-License-Identifier instead of a verbose license text.
> 
> The original text refers to version 2 so also update MODULE_LICENSE() to
> "GPL v2" instead of "GPL".

This is not necessary as GPL is the same as GPL v2

commit bf7fbeeae6db644ef5995085de2bc5c6121f8c8d
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Fri Feb 8 17:02:56 2019 +0100

    module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity
    
and documentation/process/license-rules.rst:

   The valid license strings for MODULE_LICENSE() are:

    ============================= =============================================
    "GPL"			  Module is licensed under GPL version 2. This
				  does not express any distinction between
				  GPL-2.0-only or GPL-2.0-or-later. The exact
				  license information can only be determined
				  via the license information in the
				  corresponding source files.

    "GPL v2"			  Same as "GPL". It exists for historic
				  reasons.


