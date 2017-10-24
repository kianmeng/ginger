// Create a class for the element
class ForceDirectedGraph extends HTMLElement {

    // Before the element is attached to the DOM
    constructor() {
        // If you define a ctor, always call super() first!
        // This is specific to CE and required by the spec.
        super();

        // Create a shadow root
        const shadow = this.attachShadow({
            mode: "closed"
        });

        // Get properties
        this.width = this.getAttribute("svg-width");
        this.height = this.getAttribute("svg-height");
        this.endpoint = this.getAttribute("endpoint");
        this.resourceId = this.getAttribute("resource-id");

        // Add the svg element to the shadow root.
        this.svg = d3.select(shadow).append("svg");

        // Set svg dimension attributes
        this.svg
            .attr("width", this.width)
            .attr("height", this.height);

        this.simulation = d3.forceSimulation()
            .force("link", d3.forceLink().id(d => d.id))
            .force("charge", d3.forceManyBody())
            .force("center", d3.forceCenter(this.width / 2, this.height / 2));

        this.color = d3.scaleOrdinal(d3.schemeCategory20);
    }

    // After the element is attached to the DOM
    connectedCallback() {

        // Get the graph nodes and edges from the endoint and int the FDG
        d3.json(`${this.endpoint}?id=${this.resourceId}`, (error, graph) => {
            if (error) {
                console.log("Something went wrong while getting the data", error);
                return;
            }

            this.link = this.svg
                .selectAll(".line")
                .data(graph.links)
                .enter().append("line")
                .attr("stroke", "#ccc")
                .attr("stroke-width", "1px");

            this.nodes = this.svg
                .selectAll(".node")
                .data(graph.nodes)
                .enter().append("g")
                .call(d3.drag()
                    .on("start", this.dragstarted.bind(this))
                    .on("drag", this.dragged.bind(this))
                    .on("end", this.dragended.bind(this)));

            this.labels = this.nodes
                .append("circle")
                .attr("r", 6)
                .attr("fill", "red")

            this.labels = this.nodes
                .append("text")
                .attr("dx", 12)
                .attr("dy", ".35em")
                .text(d => d.title);

            this.simulation
                .nodes(graph.nodes)
                .on("tick", this.tick.bind(this));

            this.simulation.force("link")
                .links(graph.links);

        });
    }

    // Tick reffers to the browsers Animation Frame
    tick() {
        this.link
            .attr("x1", d => d.source.x)
            .attr("y1", d => d.source.y)
            .attr("x2", d => d.target.x)
            .attr("y2", d => d.target.y);

        this.nodes
            .attr("transform", d =>
                "translate(" + d.x + "," + d.y + ")");
    }

    dragstarted(d) {
        if (!d3.event.active) this.simulation.alphaTarget(0.3).restart();
        d.fx = d.x;
        d.fy = d.y;
    }

    dragged(d) {
        d.fx = d3.event.x;
        d.fy = d3.event.y;
    }

    dragended(d) {
        if (!d3.event.active) this.simulation.alphaTarget(0);
        d.fx = null;
        d.fy = null;
    }
}

// Define the new element
customElements.define("force-directed-graph", ForceDirectedGraph);
