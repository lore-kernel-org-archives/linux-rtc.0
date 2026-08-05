Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ED634AB19;
	Wed,  5 Aug 2026 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964687; cv=none; b=N/UuJPH//1IX4MmuaiBqzDpfSIYe0YVfXd2/hVJUtVO1ENpeXFKQRWK7NLc5h1l5AExIKNjDQomjrGkOyAMJ69uIjwzxZ/oXBUKSvdn7A9kpnniJj4djSadwG0h8UoK8OfR3quYqg9nc7pLT9jW/rxDlPoXJJ731xG0aKxxv8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964687; c=relaxed/simple;
	bh=4GLvRlLi4q8Grvdog0DaP2fDBRcmhDzccrZBZ3fJK8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mI79Zhf9iZt6zhmXagE+g2ltzFFs128zsUYawudlcBg/MeVyCuMjWt3JDhDKkIIh1dKjtqZ9UnsbiE6d6fqDr7k59FeWeeXtaQHmSSFpG/I2JNG8YXmAwkxynWpJE/KrZzX4ek49dWQ5NyS91pw/QiQhzaIJePlUSOb88V6NvHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzVDeWf6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzVDeWf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68B41F000E9;
	Wed,  5 Aug 2026 21:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785964678;
	bh=Ih4CY4loRfiDz+HhU7oDKDGbRZnNGt6ynExU5jVOQBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XzVDeWf6pBGX46ux0XWzaR8sUPE3l7vCwP55FklFMecTN44+0Ah6S/TLsZNfrRu6r
	 oDW7mfS/iEqRCyUEus4B8pNr8yp6YOYVjoLpzn2FDy3hlbKYgwzDmd5bsze7Vd26Pe
	 wGHU01WyAQSi/NRZHGvmEkFMuJ5O8HIUWDRYGUdxEH2wK5GpQaitb4kTC34fm4h2FY
	 eynjndQUG0sR0lHqjZn4ARVtfESDDY8LFSie9e7VEiy5gPANKSQGDWET8yPSSDKnLN
	 uWKTan2BlBozUDvj6Tz6BfbRjsTY2mbAJ0ivIsGs7ToMPzDtFQrdM7aJsBOIjr24Bp
	 7tv4M0bdkWNgw==
Date: Wed, 5 Aug 2026 16:17:57 -0500
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: alexandre.belloni@bootlin.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul@crapouillou.net,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: rtc: ingenic,rtc: Use generic
 power-controller schema
Message-ID: <20260805211716.GA1799400-robh@kernel.org>
References: <20260804144553.2518722-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804144553.2518722-1-peng.fan@oss.nxp.com>

On Tue, Aug 04, 2026 at 10:45:53PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the binding to use the generic power-controller schema instead by
> referencing power-controller.yaml and removing the local
> `system-power-controller` property definition.
> 
> Acked-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V1:
>  The power-controller.yaml has been merged in dt-schema, so
>  resend this patch picked from link [1]. A-b tag is kept, since
>  no changes.
>  [1] https://lore.kernel.org/all/20260316-power-controller-v1-5-92c80e5e1744@nxp.com/

This needs to wait a cycle as the dtschema dependency is not yet in a 
release.

Rob
