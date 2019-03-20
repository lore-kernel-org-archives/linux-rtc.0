Return-Path: <SRS0=1ScD=RX=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCB9C43381
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 13:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA4A213F2
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 13:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553088721;
	bh=1ZzFq1q8c4hJrzDVsFTmc1Txh4+0yVeduw2as9aaa2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UBTJAZvsRVR3NZ4KqjFp+G2M3V0VsLkUVX3XA4g5RACt0JaqTIGIVqQBBkKpNXTKe
	 oirjolahW4UoX3F+TT6KJUmJbaKjk91Zu3iJQ6frazfF/njzzfTbPFhN0RUrFFwsKL
	 m6unAmOvylpH4UkThZuI7gNF8QKVUwxc9Ts2TtR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfCTNcB (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:32:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34244 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCTNcB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 20 Mar 2019 09:32:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id j89so2288522ljb.1;
        Wed, 20 Mar 2019 06:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1ZzFq1q8c4hJrzDVsFTmc1Txh4+0yVeduw2as9aaa2M=;
        b=kQBY213nCxB09xtfKMcD/ct2SHU3mDR5azhhuJfbM/q5Epu0dEUHm5G0d+uEcKfrI8
         KbyCVdBlw1aGoFy9+6EiYHXOC+++NiqyhcdcI5GLfpG/x1/AqBQeIVH3GKVEFkra/muD
         IAbB+WUY9Xt9rJ/ABCMNaPW7srKxApS7DFqCXFzhixwLErK2U5CyAAhXEgR0WH1SdQHV
         JEu/Z9WLEZJR7lOiJii1N72H2W1kG0yi328LDJ7qqMam+Cg32fh0yrXwAKExtXc+xyhp
         nFsj/6i/S5Eh/K7fbCa26PAtZhLrYkd62RF09SCVitSEkZaekwmIgOELEEsiHjdicPwE
         kV+Q==
X-Gm-Message-State: APjAAAUg4MEMn2IbK+DskFlRrx3U9SJhKkrh4BlHgDUahnjXFXmYYHwg
        WgLI2YxjxR9Zd4ZIriACEhkjay8w
X-Google-Smtp-Source: APXvYqxRMii98cq3YH8ALWQrA0i4VqdQnk2KJ0enAJ7UdkXFJUcmLsDB+ic1AykUZ62QLy2KD3vy7A==
X-Received: by 2002:a2e:8117:: with SMTP id d23mr17394104ljg.32.1553088718155;
        Wed, 20 Mar 2019 06:31:58 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id a11sm347838ljf.68.2019.03.20.06.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 06:31:57 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1h6bJx-000808-Lf; Wed, 20 Mar 2019 14:31:53 +0100
Date:   Wed, 20 Mar 2019 14:31:53 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rtc: omap: checkpatch cleanup
Message-ID: <20190320133153.GH15782@localhost>
References: <20190320124535.14606-1-alexandre.belloni@bootlin.com>
 <20190320124535.14606-3-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320124535.14606-3-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, Mar 20, 2019 at 01:45:35PM +0100, Alexandre Belloni wrote:
> Properly align code with opening parenthesis.

FWIW, this is a checkpatch --strict warning you're addressing, and not
something that is enforced by the coding standard.

Indenting continuation lines at least two tabs further conforms with the
coding style which says to indent lines substantially to the right (and
you don't have to run around realigning things should a function call be
renamed, etc).

But your call.

Johan
