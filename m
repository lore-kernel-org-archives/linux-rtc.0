Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A343112;
	Wed, 18 Oct 2023 05:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB897BA;
	Tue, 17 Oct 2023 22:31:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1099367373; Wed, 18 Oct 2023 07:31:47 +0200 (CEST)
Date: Wed, 18 Oct 2023 07:31:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Yangbo Lu <yangbo.lu@nxp.com>, Joshua Kinard <kumba@gentoo.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
	open list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH 5/5] modules: only allow symbol_get of
 EXPORT_SYMBOL_GPL modules
Message-ID: <20231018053146.GA16765@lst.de>
References: <20230801173544.1929519-1-hch@lst.de> <20230801173544.1929519-6-hch@lst.de> <bf555c2a4df5196533b6e614cc57638004dfb426.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf555c2a4df5196533b6e614cc57638004dfb426.camel@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 01:30:18AM +0100, David Woodhouse wrote:
> 
> But if we're going to tolerate the core kernel still exporting some
> stuff with EXPORT_SYMBOL, why isn't OK for a GPL-licensed module do to
> the same? Even an *in-tree* GPL-licensed module now can't export
> functionality with EXPORT_SYMBOL and have it used with symbol_get().

Anything using symbol_get is by intent very deeply internal for tightly
coupled modules working together, and thus not a non-GPL export.

In fact the current series is just a stepping stone.  Once some mess
in the kvm/vfio integration is fixed up we'll require a new explicit
EXPORT_SYMBOL variant as symbol_get wasn't ever intended to be used
on totally random symbols not exported for use by symbol_get.
